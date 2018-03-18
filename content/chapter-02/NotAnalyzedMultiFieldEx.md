# Not Analyzed & Multi-Fields Exercise #

* Login into you virtual box
* Delete previously created index and its mapping:
```
curl -XDELETE 'localhost:9200/ordering?pretty'
```
* Post new document:
```
curl -H 'Content-Type: application/json' -XPOST 'localhost:9200/ordering/doc/1?pretty' -d \
'{"id": "1", "placedOn": "2016-10-17T13:03:30.830Z"}'
```
* Fetch mapping:
```
curl 'localhost:9200/ordering/doc/_mapping?pretty'
```
* Expected response:
```
{
  "ordering" : {
    "mappings" : {
      "doc" : {
        "properties" : {
          "id" : {
            "type" : "text",
            "fields" : {
              "keyword" : {
                "type" : "keyword",
                "ignore_above" : 256
              }
            }
          },
          "placedOn" : {
            "type" : "date"
          }
        }
      }
    }
  }
}

```
* Add mapping for a new field
```
curl -H 'Content-Type: application/json' -XPUT 'localhost:9200/ordering/doc/_mapping?pretty' -d \
'{
  "doc" : {
    "properties" : {
      "id" : {
        "type" : "text"
      },
      "placedOn" : {
        "type" : "date",
        "format" : "strict_date_optional_time||epoch_millis"
      },
      "trackingId" : {
        "type" : "keyword",
        "index" : false
      }
    }
  }
}'
```
* Expected response:
```
{"acknowledged":true}
```
* Populate new order with spaces in id and trackingId fields/properties:  
```
curl -H 'Content-Type: application/json' -XPOST 'localhost:9200/ordering/doc/1?pretty' -d \
'{
  "id": "orderId with spaces", 
  "placedOn": "2016-10-17T13:03:30.830Z",
  "trackingId": "trackingId with spaces"
}'
```  
* Let's run first search:
```
curl 'localhost:9200/ordering/doc/_search?pretty&q=id:orderId'
```
* Did you get any results?
* Let's run second search:
```
curl 'localhost:9200/ordering/doc/_search?pretty=true&q=trackingId:trackingId'
```
* Did you get any results?  
* What's the difference in behaviour and why?  
* Adding mapping for multi-field:
```
curl -H 'Content-Type: application/json' -XPUT localhost:9200/ordering/doc/_mapping -d \ '
{
  "doc" : {
    "properties":{  
       "streetName":{  
          "type":"text",
          "fields":{  
             "notparsed":{  
                "type":"keyword",
                "index":false
             }
          }
       }
    }
  }
}'
```
* Re-populate the data:
```
curl -H 'Content-Type: application/json' -XPOST 'localhost:9200/ordering/doc/1?pretty' -d '
{
  "id": "string with spaces", 
  "placedOn": "2016-10-17T13:03:30.830Z",
  "streetName": "name with spaces"
}'
```
* Let's search for the street name:
```
curl 'localhost:9200/ordering/doc/_search?pretty&q=streetName:name'
```
* Let's search for the street name on not-parsed field:
```
curl 'localhost:9200/ordering/doc/_search?pretty=true&q=streetName.notparsed:name'
```
* Let's search for the street name on not-parsed field again:
```
curl 'localhost:9200/ordering/doc/_search?pretty&q=streetName.notparsed:name%20with%20spaces'
```
* What are results in the search #1, #2, and #3; and what is the reason for these results?
