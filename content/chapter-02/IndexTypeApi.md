# Index and Type API #

* How do we create an index?
* Index will be created lazily by Elasticseach when we post a document:
```
curl  -H 'Content-Type: application/json' -XPOST localhost:9200/ordering/doc/1 -d '
{"id": "1", "placedOn": "2016-10-17T13:03:30.830Z"}'
```
* To retrieve the document just posted:
```
curl 'localhost:9200/ordering/_search?pretty=true'
```
* Expected result:
```
{
  "took" : 4,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : 1,
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "ordering",
        "_type" : "doc",
        "_id" : "1",
        "_score" : 1.0,
        "_source" : {
          "id" : "1",
          "placedOn" : "2016-10-17T13:03:30.830Z"
        }
      }
    ]
  }
}
```