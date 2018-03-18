# Not Analyzed & Multi-Fields #

* Lucene and hence Elasticsearch break strings into terms using <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-tokenizers.html" target="_blank">built-in</a> or custom tokenizers 
* Some strings don't make sense to tokenize e.g. <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">uuid or guid</a> often used as equivalent of a primary key and/or unique identifier
* `"index": false` - Elasticsearch mapping option to suppress tokenization:
```
curl -H 'Content-Type: application/json' -XPUT 'localhost:9200/ordering/_mapping/doc?pretty' -d '
{
   "doc": {
      "properties": {
         "id": {
            "type": "text",
            "index": false
         }
      }
   }
}'
```
* What you think difference will be searching or aggregating tokenized uuid/guid vs. non-tokenized uuid/guid property?
* What if I need both tokenized and non-tokenized option for the same field?
* <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/multi-fields.html" target="_blank">Multi-Fields</a> Mapping allows double indexing the same data:
```
curl -H 'Content-Type: application/json' -XPUT 'localhost:9200/ordering/_mapping/doc?pretty' -d '
{  
   "doc":{  
      "properties": {  
         "streetName": {
            "type":"text",
            "fields": {  
               "notparsed": {  
                  "type":"keyword",
                  "index":false
               }
            }
         }
      }
   }
}'
```
