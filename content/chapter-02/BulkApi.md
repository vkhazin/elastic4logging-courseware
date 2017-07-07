# Bulk API #

* Perform many index/delete operations in a single API call
* Greatly increases the indexing speed
* End-point:
```
POST localhost:9200/_bulk
```
* Format of bulk request body is not json per ce:
```
request-meatadata\n
document-data\n
....
request-meatadata\n
document-data\n
```
* Sample body:
```
{"index":{"_index":"logstash-2015.05.18","_type":"log"}}
{"@timestamp":"2015-05-18T09:03:25.877Z","ip":"185.124.182.126","response":"404"}
```
* Psst: don't forget new line at the end of file!