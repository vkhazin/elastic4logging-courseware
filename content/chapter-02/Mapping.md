# Mapping #

* Defines how document and its fields are stored and indexed
* Mapping can be derived dynamically by Elasticsearch
* Handful core data types are <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-types.html" target="_blank">supported</a>
* Mapping can be added to existing index for <a style="color:red">new fields</a>
* Existing field mapping not always possible to modify
* Elasticsearch will derive mapping for new fields:
```
curl -H 'Content-Type: application/json' -XPOST localhost:9200/ordering/doc/1 -d '
{"id": "1", "placedOn": "2016-10-17T13:03:30.830Z"}'
```
* Retrieving existing mappings:
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
* Rich support for <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-date-format.html#built-in-date-formats" target="_blank">date-time formats</a>