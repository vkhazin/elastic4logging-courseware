# Aggregation Exercise #

* Log-in into your ElasticSearch sandbox
* Make sure elastic search is running:
```
sudo service elasticsearch restart
```
* Populate sample data:
```
curl https://s3.us-east-2.amazonaws.com/elasticsearch-courseware/sample-data/logs.json -o logs.json
curl -XPOST 'localhost:9200/_bulk' --data-binary "@logs.json"
```
* Confirm there are some records to search on:
```
curl 'http://localhost:9200/logstash*/_search?pretty=true'
```
* Why there is a star after the index name?
* Let's create date-time histogram using ```@timestamp``` field
```
curl 'http://localhost:9200/logstash*/_search?pretty=true' -d '
{
  "size": 0,
  "aggs": {
    "timestamp": {
      "date_histogram": {
      "field": "@timestamp",
      "interval": "hour"
      }
    }
  }
}'
```
* What buckets did you get?
* Let's try ```terms``` aggregation:
```
curl 'http://localhost:9200/logstash*/_search?pretty=true' -d '
{
  "size": 0,
  "aggs": {
    "ip-addres": {
      "terms": {
      "field": "ip.keyword"
      }
    }
  }
}'
```
* Using elastic search on-line documentation find out what's ```doc_count_error_upper_bound``` and ```sum_other_doc_count```
* Take a moment to understand the variety of <a href="https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations.html" target="_blank">aggregation types</a>