# Ip Address Aggregation #

* Similar to date histogram and date range aggregation addresses the need for context specific data analysis
* Sample Query:
```
{
  "aggs" : {
    "ip_ranges" : {
      "ip_range" : {
      "field" : "ip",
      "ranges" : [
          { "from": "0.0.0.0", "to": "10.0.0.5" },
          { "from" : "10.0.0.5", "to": 10.10.10.254}
        ]
      }
    }
  }
}
```
* Sample result:
```
{
  "aggregations": {
    "ip_ranges": {
    "buckets" : [
        {
          "to": "10.0.0.5",
          "doc_count": 4
        },
        {
          "from": "10.0.0.5",
          "doc_count": 6
        }
      ]
    }
  }
}
```
* Ranges can also be defined as CIDR masks:
```
{
  "aggs" : {
    "ip_ranges" : {
      "ip_range" : {
      "field" : "ip",
      "ranges" : [
          { "mask" : "10.0.0.0/25" },
          { "mask" : "10.0.0.127/25" }
        ]
      }
    }
  }
}
```
* CIDR mask result:
```
{
  "aggregations": {
    "ip_ranges": {
      "buckets": [
        {
          "key": "10.0.0.0/25",
          "from": "10.0.0.0",
          "to": "10.0.0.127",
          "doc_count": 127
        },
        {
          "key": "10.0.0.127/25",
          "from": "10.0.0.0",
          "to": "10.0.0.127",
          "doc_count": 127
        }
      ]
    }
  }
}
```