curl https://s3.us-east-2.amazonaws.com/elasticsearch-courseware/sample-data/logs.json -o logs.json

curl -XDELETE localhost:9200/logstash-2015.05.20
curl -XPUT localhost:9200/logstash-2015.05.20 -d '
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            },
            "ip": {
              "type": "ip"
            },
            "clientip": {
              "type": "ip"
            }            
          }
        }
      }
    }
  }
}'

curl -XDELETE localhost:9200/logstash-2015.05.18
curl -XPUT localhost:9200/logstash-2015.05.18 -d '
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            },
            "ip": {
              "type": "ip"
            },
            "clientip": {
              "type": "ip"
            }            
          }
        }
      }
    }
  }
}'

curl -XDELETE localhost:9200/logstash-2015.05.19
curl -XPUT localhost:9200/logstash-2015.05.19 -d '
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            },
            "ip": {
              "type": "ip"
            },
            "clientip": {
              "type": "ip"
            }            
          }
        }
      }
    }
  }
}'

 curl -XPUT localhost:9200/_bulk --data-binary "@./logs.json"