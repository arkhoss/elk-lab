# elk-lab
A Full ELK lab deployment

Docker and ELK configuration examples. 
Learn how to use docker and ELK to monitor apps and hosts, nodes, containers and services.

**Warning**
> THIS IS A WORK IN PROGESS! 

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

Set Some permissions
```bash
chmod +755 scripts/*
```

This steps needs sudo/root, and build

```bash
$ sudo make setup
=> ACLs on /var/run/docker.sock OK
vm.max_map_count = 262144
=> vm.max_map_count=262144 OK
46da30a7caea90bc5fc77d50abe5d4696042cccb2444e85a2a78fa3c87a53922
elasticsearch uses an image, skipping
kibana uses an image, skipping
Building metricbeat
Step 1/10 : FROM docker.elastic.co/beats/metricbeat:7.1.1
 ---> 630fdc24613d
Step 2/10 : ARG METRICBEAT_FILE=metricbeat.yml
 ---> Using cache
 ---> 2f7782b03011
Step 3/10 : COPY ${METRICBEAT_FILE} /usr/share/metricbeat/metricbeat.yml
 ---> Using cache
 ---> 3546bc58a253
Step 4/10 : USER root
 ---> Using cache
 ---> 4f35aaaef73a
Step 5/10 : RUN yum -y install nc
 ---> Using cache
 ---> f7598ec97ffd
Step 6/10 : RUN mkdir /var/log/metricbeat     && chown metricbeat /usr/share/metricbeat/metricbeat.yml     && chmod go-w /usr/share/metricbeat/metricbeat.yml     && chown metricbeat /var/log/metricbeat
 ---> Using cache
 ---> bc81d37d0409
Step 7/10 : COPY entrypoint.sh /usr/local/bin/custom-entrypoint
 ---> Using cache
 ---> 1fad90135fa9
Step 8/10 : RUN chmod +x /usr/local/bin/custom-entrypoint
 ---> Using cache
 ---> b8fcc1e2946f
Step 9/10 : USER metricbeat
 ---> Using cache
 ---> ab1c44ae1be6
Step 10/10 : ENTRYPOINT ["/usr/local/bin/custom-entrypoint"]
 ---> Using cache
 ---> f4234a095190
Successfully built f4234a095190
Successfully tagged elk-lab_metricbeat:latest
Building metricbeat-host
Step 1/10 : FROM docker.elastic.co/beats/metricbeat:7.1.1
 ---> 630fdc24613d
Step 2/10 : ARG METRICBEAT_FILE=metricbeat.yml
 ---> Using cache
 ---> 2f7782b03011
Step 3/10 : COPY ${METRICBEAT_FILE} /usr/share/metricbeat/metricbeat.yml
 ---> Using cache
 ---> 6c3978a06ec3
Step 4/10 : USER root
 ---> Using cache
 ---> d48002dc2d74
Step 5/10 : RUN yum -y install nc
 ---> Using cache
 ---> fde9a3513662
Step 6/10 : RUN mkdir /var/log/metricbeat     && chown metricbeat /usr/share/metricbeat/metricbeat.yml     && chmod go-w /usr/share/metricbeat/metricbeat.yml     && chown metricbeat /var/log/metricbeat
 ---> Using cache
 ---> 737eec591cd1
Step 7/10 : COPY entrypoint.sh /usr/local/bin/custom-entrypoint
 ---> Using cache
 ---> 0a647323f122
Step 8/10 : RUN chmod +x /usr/local/bin/custom-entrypoint
 ---> Using cache
 ---> c61cf96fb62d
Step 9/10 : USER metricbeat
 ---> Using cache
 ---> e303f46ea941
Step 10/10 : ENTRYPOINT ["/usr/local/bin/custom-entrypoint"]
 ---> Using cache
 ---> cd693e16e535
Successfully built cd693e16e535
Successfully tagged elk-lab_metricbeat-host:latest
```


## Host Monitoring

We are assuming your `docker0` interface IP is: `inet 172.17.0.1  netmask 255.255.0.0  broadcast 0.0.0.0`
If not the case, please adjust the configuration in `docker-compose.yml` file for service `metricbeat-host`.

```yaml
metricbeat-host:
  ...
  environment:
    - HOST_ELASTICSEARCH=elasticsearch:9222
    - HOST_KIBANA=kibana:5666
  extra_hosts:
    - "elasticsearch:172.17.0.1" # The IP of docker0 interface to access host from container
    - "kibana:172.17.0.1" # The IP of docker0 interface to access host from container
  network_mode: host # Mandatory to monitor host filesystem, memory, processes,...
```

Start monitoring your host.

```bash
$ make start-monitoring-host
Creating elk-lab-elasticsearch ... done
elk-lab-elasticsearch is up-to-date
Creating elk-lab-kibana ... done
Creating elk-lab-metricbeat-host ... done
```
