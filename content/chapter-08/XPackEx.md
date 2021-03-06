# X-Pack Exercise #

* Stop ElasticSearch and Kibana:
```
sudo service kibana stop && sudo service elasticsearch stop
```
* Installing X-Pack plug-in for ElasticSearch:
```
cd /usr/share/elasticsearch/
sudo ./bin/elasticsearch-plugin install x-pack
```
* Install X-Pack plug-in for Kibana (will take some time):
```
cd /usr/share/kibana/
sudo ./bin/kibana-plugin install x-pack
```
* Modify /etc/kibana/kibana.yml:
```
sudo nano /etc/kibana/kibana.yml
```
* Values to change:
```
elasticsearch.username: "elastic"
elasticsearch.password: "changeme"
```
* Start ElasticSearch and Kibana services:
```
sudo service elasticsearch start && sudo service kibana start
```
* Navigate to http://ip-address:5601/
* Login with default credentials: elastic/changeme
* Explore the 'Monitoring' and 'Management' links
* Now, we broke things, let's fix them:
  * Logstash config needs credentials
  * Filebeat config needs credentials