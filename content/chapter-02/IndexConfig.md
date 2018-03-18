# Index Configuration #

* By default each new index has 5 shards and 1 replica
* Each index can be configured with desired number of shard during creation:
```
curl -H 'Content-Type: application/json' -XPUT 'localhost:9200/ordering' -d '
{
	"settings": {
		"number_of_shards" :   1,
		"number_of_replicas" : 0
	}
}'
```
NOTE: Starting version 6 header for PUT method must be provided with curl command: `-H 'Content-Type: application/json'`  

* Do you recall discussion about multi-index search capabilities?
