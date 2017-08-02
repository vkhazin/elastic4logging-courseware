# Chapter 8: Watcher #

* Previously a plug-in for ElasticSrearch
* Now installed as part of X-Pack
* Encourages integration and automation for a wide range of use-cases:
  * Monitor your infrastructure
  * Track network activity
  * Monitor health of ElasticSearch cluster/node/index
* Gives you the power of the Elasticsearch DSL to identify changes in your data
* Create notifications when:
  * The same user logins from 4 disperse geographical locations in 10 min
  * Frequency of request for a single ip address spikes 1,000% in last hour
  * Elastic Search cluster is experiencing increased exceptions rate in the logs