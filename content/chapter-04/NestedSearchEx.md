# Nested Search Exercise #

* Log-in into your ElasticSearch sandbox
* Make sure elastic search is running:
```
sudo service elasticsearch restart
```
* Populate sample data using ```_bulk``` api:
```
curl -XPOST http://localhost:9200/_bulk -d '{"index":{"_index":"nested-data","_type":"groups", "_id":"fans"}}
{"group":"fans","members":[{"first":"John","last":"Smith"},{"first":"Alice","last":"White"}]}
{"index":{"_index":"nested-data","_type":"groups", "_id":"supporters"}}
{"group":"supporters","members":[{"first":"Alice","last":"Smith"},{"first":"John","last":"White"}]}
'
```
* Confirm data has been populated:
```
curl 'http://localhost:9200/nested-data/groups/_search?pretty=true'
```
* Expected result:
```
{
  "took" : 2,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "hits" : {
    "total" : 2,
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "nested-data",
        "_type" : "groups",
        "_id" : "supporters",
        "_score" : 1.0,
        "_source" : {
          "group" : "supporters",
          "members" : [
            {
              "first" : "Alice",
              "last" : "Smith"
            },
            {
              "first" : "John",
              "last" : "White"
            }
          ]
        }
      },
      {
        "_index" : "nested-data",
        "_type" : "groups",
        "_id" : "fans",
        "_score" : 1.0,
        "_source" : {
          "group" : "fans",
          "members" : [
            {
              "first" : "John",
              "last" : "Smith"
            },
            {
              "first" : "Alice",
              "last" : "White"
            }
          ]
        }
      }
    ]
  }
}
```
* Let's find group with ```John Smith``` in it:
```
curl -XPOST 'http://localhost:9200/nested-data/groups/_search?pretty=true' -d '
{
  "query" : {
      "bool" : {
        "must" : [
          {
              "match" : {"members.first" : "John"}
          },
          {
              "match" : {"members.last" : "Smith"}
          }
        ]
      }
    }
  }
}'
```
* Expected result from Lucene's perspective:
```
{
  "took" : 3,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "hits" : {
    "total" : 2,
    "max_score" : 0.51623213,
    "hits" : [
      {
        "_index" : "nested-data",
        "_type" : "groups",
        "_id" : "supporters",
        "_score" : 0.51623213,
        "_source" : {
          "group" : "supporters",
          "members" : [
            {
              "first" : "Alice",
              "last" : "Smith"
            },
            {
              "first" : "John",
              "last" : "White"
            }
          ]
        }
      },
      {
        "_index" : "nested-data",
        "_type" : "groups",
        "_id" : "fans",
        "_score" : 0.51623213,
        "_source" : {
          "group" : "fans",
          "members" : [
            {
              "first" : "John",
              "last" : "Smith"
            },
            {
              "first" : "Alice",
              "last" : "White"
            }
          ]
        }
      }
    ]
  }
}
```
* Is that the expected result from the human perspective?
* To address the imperfection in the results we will recreate the index with nested mapping
* Delete the index:
```
curl -XDELETE 'localhost:9200/nested-data'
```
* Re-create the index with mapping for nested type:
```
curl -XPUT 'localhost:9200/nested-data' -d '
{
  "mappings": {
    "groups": {
      "properties": {
        "members": {
          "type": "nested"
        }
      }
    } 
  }
}'
```
* Re-populate sample data:
```
curl -XPOST http://localhost:9200/_bulk -d '{"index":{"_index":"nested-data","_type":"groups", "_id":"fans"}}
{"group":"fans","members":[{"first":"John","last":"Smith"},{"first":"Alice","last":"White"}]}
{"index":{"_index":"nested-data","_type":"groups", "_id":"supporters"}}
{"group":"supporters","members":[{"first":"Alice","last":"Smith"},{"first":"John","last":"White"}]}
'
```
* Re-run the query:
```
curl -XPOST 'http://localhost:9200/nested-data/groups/_search?pretty=true' -d '
{
  "query" : {
      "bool" : {
        "must" : [
          {
              "match" : {"members.first" : "John"}
          },
          {
              "match" : {"members.last" : "Smith"}
          }
        ]
      }
    }
  }
}'
```
* What results did you get?
* The reason for no results is that nested query uses different syntax:
```
curl -XPOST 'http://localhost:9200/nested-data/groups/_search?pretty=true' -d '
{
  "query": {
    "nested": {
      "path": "members",
      "query": {
        "bool": {
          "must": [
            { "match": { "members.first": "John" }},
            { "match": { "members.last":  "Smith" }} 
          ]
        }
      }
    }
  }
}'
```
* Expected Results:
```
{
  "took" : 6,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "hits" : {
    "total" : 1,
    "max_score" : 1.3862944,
    "hits" : [
      {
        "_index" : "nested-data",
        "_type" : "groups",
        "_id" : "fans",
        "_score" : 1.3862944,
        "_source" : {
          "group" : "fans",
          "members" : [
            {
              "first" : "John",
              "last" : "Smith"
            },
            {
              "first" : "Alice",
              "last" : "White"
            }
          ]
        }
      }
    ]
  }
}
```
* Is the nested document mapping worth the hassle?
