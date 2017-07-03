# Data Handling #

* Document is a unit of storage, indexing, search, and aggregation
* 3rd norm of <a href="https://en.wikipedia.org/wiki/Database_normalization" target="_blank">normalization</a> (or beyond)  does not apply to ElasticSearch
* ElasticSearch supports no join or its close equivalents
* Document indexing, searching, and aggregation uses no locks
* ElasticSearch designed for scalability and for performance
* Data durability is not as high priority
* Distributed transaction support is not implemented
* Data is fashed to disk every 5 sec only
* Any impact on the log processing and aggregation use-case?