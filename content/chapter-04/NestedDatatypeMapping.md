# Nested Datatype Mapping #

* To maintain granularity of ```members``` array indexing - ```nested``` datatype can be used to index each object as independent, hidden documents:
```
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
}
```
* With above mapping member ```John White``` or ```Alice Smith``` won't be found