# Terms Aggregation #

* Aggregation query syntax: 
```
curl -XPOST 'localhost:9200/ordering/order/_search?pretty=true' -d '
{
  "size": 0, 
  "aggregations": {
    "order-status": {
      "terms": {
        "field": "status.keyword"
      }
    }
  }
}'
```
* "size": 0 - suppress query results to fetch aggregations results only
* "aggregations" or "aggs" - part of ElasticSearch Dsl
* "order-status" - arbitrary name for aggregation
* "terms" - type of aggregation to use
* "status.keyword" - multi-field mapping for "status" property of json document