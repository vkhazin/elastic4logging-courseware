# Nested Datatype Querying #

* The query against nested objects is executed as if the nested documents were indexed independently from the parent document and one from another:
```
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
}
```
* <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/nested.html" target="_blank">Additional options available for nested datatype mapping, querying, and aggregation<a>