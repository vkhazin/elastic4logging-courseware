# Nested Datatype #

* Nested is a specialized version of 'object' datatype that allows querying of arrays of objects independently one from another
* Lucene has no concept of inner objects and hence data is flattened when being indexed with not quite as expected behavior.
* Data posted
```
{
  "group" : "fans",
  "members" : [ 
    {
      "first" : "John",
      "last" :  "Smith"
    },
    {
      "first" : "Alice",
      "last" :  "White"
    }
  ]
}
```
* Indexed as:
```
{
  "group" :        "fans",
  "members.first" : [ "alice", "john" ],
  "members.last" :  [ "smith", "white" ]
}
```
* What you think would be a consequence of such indexing? 
* Should you be able to find person ```John White``` or ```Alice Smith```?