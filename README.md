# elk-lab
A Full ELK lab deployment

Docker and ELK configuration examples. 
Learn how to use docker and ELK to monitor apps and hosts, nodes, containers and services.

**Warning**
> This project is built for example and testing. 
> DO NOT use any part of it in production unless you know exactly what you are doing.

| Name  | Version |
| ------------- | ------------- |
| Docker  | 18.09.6 |
| Docker-compose  | 1.24.0, build 0aa59064 |
| Elasticsearch  | 7.1.1 |
| Logstash | 7.1.1 |
| Filebeat | 7.1.1 |
| Metricbeat  | 7.1.1 |
| Kibana  | 7.1.1 |
| Apache | 2.4.39-alpine |
| MongoDB | 3.5.18-jessie |
| MySQL | 8.0.16 |
| Nginx | 1.17.0-alpine |
| RabbitMQ | 3.7.15-management-alpine |
| Redis | 3.2.11-alpine |


## Install

Clone the repository

```bash
git clone git@github.com:arkhoss/elk-lab.git && cd elk-lab
```

Bring up Vagrant
> install vagrant

```bash
sudo apt-get install vagrant
cd vagrant
vagrant up
```
Get inside orchestration host and clone the repo
```bash
vagrant ssh orch
git clone git@github.com:arkhoss/elk-lab.git && cd elk-lab
```
