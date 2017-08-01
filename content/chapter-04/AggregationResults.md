# Aggregation Results #

//TODO: Add sample output

* With ```"size": 0``` no hits are returned
* Aggregated data is returned with buckets
* Number of buckets limited by default to 5
* Sample output:
```
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
{
  "took" : 21,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "hits" : {
    "total" : 3,
    "max_score" : 0.0,
    "hits" : [ ]
  },
  "aggregations" : {
    "order-status" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 0,
      "buckets" : [
        {
          "key" : "pending",
          "doc_count" : 1
        },
        {
          "key" : "received",
          "doc_count" : 1
        },
        {
          "key" : "shipped",
          "doc_count" : 1
        }
      ]
    }
  }
}
``` 