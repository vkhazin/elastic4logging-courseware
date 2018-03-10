# Index #

* Index is broken down, stored, and processed as collection of shards
* A shard is a single piece of an Elasticsearch index and is a standalone Lucene index
* An index must have at least 1 (primary) shard, the number of shards are limited to 1024 per index
* By default shards distributed across cluster nodes and are searched independently
* At the completion of search individual shards results must be aggregated
* IMPORTANT! Since version 6.0 multiple mapping types has been [depricated](https://www.elastic.co/guide/en/elasticsearch/reference/master/removal-of-types.html). Each index has only one mapping type. Default type name - `doc`.
