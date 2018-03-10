# Mapping Exercise #

* Login into your sandbox
* Make sure elastic search is running:
```
sudo service elasticsearch restart
```
* Service will start but listener will take its time before responding to incoming requests:
```
curl localhost:9200
```
* Give it few minutes before you get json response
* Post new document:
```
curl -H 'Content-Type: application/json' -XPOST localhost:9200/ordering/doc/1 -d '{
  "id": "1", 
  "placedOn": "2016-10-17T13:03:30.830Z"
}'
```
* Fetch mapping:
```
curl 'localhost:9200/ordering/doc/_mapping?pretty=true'
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
* Try modifying existing mapping:
```
curl -H 'Content-Type: application/json' -XPUT 'localhost:9200/ordering/_mapping/doc?pretty' -d '
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
            "type" : "date",
            "format" : "strict_date_optional_time||epoch_millis"
          }
        }
      }
    }
  }
}'
```
* What now? Why?
* Let us try again:
```
curl -H 'Content-Type: application/json' -XPUT 'localhost:9200/ordering/_mapping/doc?pretty' -d '
{
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
        "type" : "date",
        "format" : "strict_date_optional_time||epoch_millis"
      }
    }
  }
}'
```
* Did it work? What's the difference?
* Let's modify data type for existing field
```
curl -H 'Content-Type: application/json' -XPUT 'localhost:9200/ordering/_mapping/doc?pretty' -d '
{
  "doc" : {
    "properties" : {
      "id" : {
        "type" : "double"
      },
      "placedOn" : {
        "type" : "date",
        "format" : "strict_date_optional_time||epoch_millis"
      }
    }
  }
}'
```
* Seriously, what now? Why? So much for the dynamic data mapping?
* What if we need to change data type after we have indexed the data?
* There is no (more) option to delete the mapping - delete and recreate index is the only option :-(
```
curl -XDELETE localhost:9200/ordering
curl -XPUT localhost:9200/ordering
```
* User json data from the previous step to define the mapping
* Watch out! There is no warning or confirmation using curl!
* Psst: look out for the proper response too:
```
{
  "acknowledged": true
}
```
* For fast reindexing use new feature - [Reindex API](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-reindex.html)

