# Index Configuration #

* elasticsearch.yml defines defaults for index configuration:
```
index.number_of_shards: 5
index.number_of_replicas: 1
```
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
NOTE: Starting version 6 header must be provided with curl command: `-H 'Content-Type: application/json'`  

* Do you recall discussion about multi-index search capabilities?