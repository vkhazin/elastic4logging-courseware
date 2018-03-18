# Logstash Overview #

* Open source data collection engine
* Built-in pipeline capabilities
* Originally designated for logs collection
* Diverse input/output streams: logs, http requests, webhooks, jdbc, nosql, kafka and more.
* Filters to derive structure out of unstructured data
* Key-value pairs and csv data normalization
* Local lookups and Elasticsearch queries for data enrichment
* Simplifies ingest and data analysis processes  
* Starting version 5.6 Logstash has a new feature - [modules](https://www.elastic.co/guide/en/logstash/6.1/logstash-modules.html).
Module is a pre-packaged pipeline, Kibana dashboards, and other meta files that make it easier to set up the Elastic Stack for specific use cases or data sources. One of the popular module - [netflow](https://www.elastic.co/guide/en/logstash/6.2/netflow-module.html).  

![Overview](../../media/logstash.png)