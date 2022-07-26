
Platform.Load("core", "1");

    var api = new Script.Util.WSProxy();
    var currentdate = new Date();
    var config = {
        de: "Assignment Sendable",
      filter:{
     
           Property: "EndDate", 
           SimpleOperator: "lessthan", 
           Value: currentdate
      
      },
      
        error: {
            de: "Deletion Script Log Error",
            source: "Deletion Script Activity"
        }
      
    }
    

    try {

        var result = retrieveAttributes(config);

        result.records = retrieveRecords(result.customerKey, result.columns.all, config.filter);

        result.records = formatRecords(result.records, result.columns);

        result.count = result.records.length;

        result.batches = createBatches(result.customerKey, result.records, result.columns.prims);

        result.deleted = deleteRecords(result.batches);
      

        if(result.deleted.Status == "OK" ) {
            Write(Stringify(result));
          
        } else {
            throw result.deleted;
           
        }

    } catch(err) {

        logError(err, config);
       
        

    }
  function logError(err, config) {

        var props = {
            Id: GUID(), 
            Message: Stringify(err.message), 
            Description: Stringify(err.description), 
            Source: config.error.source, 
            CreatedDate: DateTime.SystemDateToLocalDate(Now())
        }

        err.log = api.createItem("DataExtensionObject", {
            Name: config.error.de,
            Properties: wsPack(props)
        });

        if(Platform.Request.RequestURL() != null) {

            Write(Stringify(err));

        } else {

            createAutomationError();

        }

    }

   

    function deleteRecords(batches) {

        return api.deleteBatch("DataExtensionObject", batches);

    }

    function createBatches(key, records, primaries) {

        var batches = [];

        for (var k in records) {

            var keys = {};

            for(var i = 0; i < primaries.length; i++) {

                var primary = primaries[i];

                keys[primary] = records[k][primary];

            }

            batches.push({
                CustomerKey: key,
                Keys: wsPack(keys)
            });

        }

        return batches;

    }

    function formatRecords(records, columns) {

        for(var k in records) {

            var record = records[k];

            for(var name in record) {

                if(record[name].length > 0) {

                    if(inArray(columns.dates, name)) record[name] = new Date(record[name]);
                    if(inArray(columns.nums, name)) record[name] = Number(record[name]);
                    if(inArray(columns.decs, name)) record[name] = Number(record[name]);
                    if(inArray(columns.bools, name)) record[name] = (record[name].toLowerCase() == "true") ? true : false;

                }

            }

        }

        return records;

    }

    function retrieveRecords(key, cols, filter) {

        var now = new Date(),
            start = now.getTime(),
            timeOut = (60000 * 15); // 15 minutes

        var records = [],
            moreData = true,
            reqID = data = null;

        while (moreData && (new Date().getTime() - start) < timeOut) {

            moreData = false;

            if (reqID == null) {
                data = api.retrieve("DataExtensionObject[" + key + "]", cols, filter);
            } else {
                data = api.getNextBatch("DataExtensionObject[" + key + "]", reqID);
            }

            if (data != null) {

                moreData = data.HasMoreRows;
                reqID = data.RequestID;

                for (var i = 0; i < data.Results.length; i++) {

                    var props = data.Results[i].Properties;

                    records.push(wsUnpack(props));

                }

            }
        }

        if(records.length === 0) {
            
        break;
        }
        return records;

    }

    function retrieveAttributes(config) {

        var req = DataExtension.Retrieve(
            { 
                Property: "Name", 
                SimpleOperator: "equals", 
                Value: config.de 
            }
        );

        if(req[0].CustomerKey != null) {
            var customerKey = req[0].CustomerKey;
        } else {
            throw "The DataExtension \"" + config.de + "\" could not be found!";
        }

        var de = DataExtension.Init(customerKey);

        var fields = de.Fields.Retrieve();

        fields.sort(function (a, b) { 
            return (a.Ordinal > b.Ordinal) ? 1 : -1 
        });

        var columns = [],
            dates = [],
            bools = [],
            nums = [],
            decs = [],
            prims = [];

        for (var k in fields) {

            var field = fields[k];

            columns.push(field.Name);

            if(field.FieldType == "Date") dates.push(field.Name);
            if(field.FieldType == "Number") nums.push(field.Name);
            if(field.FieldType == "Boolean") bools.push(field.Name);
            if(field.FieldType == "Decimal") decs.push(field.Name);
            if(field.IsPrimaryKey == true) prims.push(field.Name);

        }

        return {
            name: config.de,
            customerKey: customerKey,
            fields: fields,
            columns: {
                all: columns,
                dates: dates,
                bools: bools,
                nums: nums,
                decs: decs,
                prims: prims
            }
        };

    }

    function inArray(arr, k) {

        var out = false;

        for (var i in arr) {

            if (arr[i] == k) out = true;

        }

        return out;

    }

    function wsPack(obj) {

        var out = [];

        for (k in obj) {

            out.push({
                Name: k,
                Value: obj[k]
            });

        }

        return out;

    }

    function wsUnpack(props) {

        var out = {};

        for(var k in props) {

            var item = props[k];

            out[item.Name] = item.Value;

        }

        return out;

    }
