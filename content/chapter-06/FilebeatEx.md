# Filebeat Setup Exercise #

* Download public key for the repository:
```
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
```
* Add repository to the list:
```
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
```
* Install Filebeat from the repository:
```
sudo apt-get update && sudo apt-get install filebeat
```
* Configure the logs location:
```
sudo nano /etc/filebeat/filebeat.yml
```
* Minimal working configuration:

```
filebeat.prospectors:
- type: log
  enabled: true
  paths:
    - /var/log/*.log

output.elasticsearch:
  hosts: ["localhost:9200"]
```
* Start Filebeat service and check the status:  
```
sudo service filebeat start && sudo service filebeat status
```
* Query Elasticsearch using curl to confirm new index has been created: 'filebeat-6.x.x-YYYY.MM.DD':  
```
curl 'localhost:9200/_cat/indices?v'
```
* Query the data inside the newly created index:
```
curl 'localhost:9200/filebeat*/_search?pretty'
```
