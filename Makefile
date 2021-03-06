# =========================================== MONITORING ===============================================================

# ----------------------- SETUP -------------------------------------------------------------------
# Useful to configure a few things on the host to allow elasticsearch and metricbeat to work.
setup:
	@./scripts/setup.sh

# ----------------------- KIBANA -------------------------------------------------------------------
start-kibana:
	@docker-compose up -d kibana
stop-kibana:
	@docker-compose stop kibana
	
# ------------------- ELASTICSEARCH ----------------------------------------------------------------
start-elasticsearch:
	@docker-compose up -d elasticsearch
stop-elasticsearch:
	@docker-compose stop elasticsearch

# ------------------- METRICBEAT -------------------------------------------------------------------
stop-metricbeat:
	@echo "== Stopping METRICBEAT=="
	@docker-compose stop metricbeat
	
# ------------------- MONITORING -------------------------------------------------------------------
create-network:
	@docker network create elk-lab || true
remove-network:
	@docker network rm elk-lab

start-monitoring: create-network start-elasticsearch start-kibana
	@docker-compose up -d metricbeat
	@echo "================= Monitoring STARTED !!!"

stop-monitoring: stop-metricbeat
	@docker-compose stop
	@echo "================= Monitoring STOPPED !!!"

stop-monitoring-host:
	@docker-compose stop metricbeat-host
	@docker-compose rm -f metricbeat-host || true

start-monitoring-host: start-elasticsearch start-kibana
	@docker-compose up -d metricbeat-host

build:
	@docker-compose build
	
# =================================================== MYSQL ============================================================
compose-mysql=docker-compose -f docker-compose.mysql.yml -p elk-lab_mysql
start-mysql:
	@$(compose-mysql) up -d mysql
stop-mysql:
	@$(compose-mysql) stop mysql

# =================================================== MONGOSB ==========================================================
compose-mongodb=docker-compose -f docker-compose.mongodb.yml -p elk-lab_mongodb
start-mongodb:
	@$(compose-mongodb) up -d mongodb
stop-mongodb:
	@$(compose-mongodb) stop mongodb

# =================================================== RABBITMQ =========================================================
compose-rabbitmq=docker-compose -f docker-compose.rabbitmq.yml -p elk-lab_rabbitmq
start-rabbitmq:
	@$(compose-rabbitmq) up -d rabbitmq
stop-rabbitmq:
	@$(compose-rabbitmq) stop rabbitmq

# =================================================== REDIS ============================================================
compose-redis=docker-compose -f docker-compose.redis.yml -p elk-lab_redis
start-redis:
	@$(compose-redis) up -d redis
stop-redis:
	@$(compose-redis) stop redis

# =================================================== NGINX ============================================================
compose-nginx=docker-compose -f docker-compose.nginx.yml -p elk-lab_nginx
start-nginx:
	@$(compose-nginx) up -d nginx
stop-nginx:
	@$(compose-nginx) stop nginx

# =================================================== APACHE ===========================================================
compose-apache=docker-compose -f docker-compose.apache.yml -p elk-lab_apache
start-apache:
	@$(compose-apache) up -d apache
stop-apache:
	@$(compose-apache) stop apache


start-all: start-apache start-nginx start-redis start-rabbitmq start-mongodb start-mysql

stop-all: stop-apache stop-nginx stop-redis stop-rabbitmq stop-mongodb stop-mysql

clean:
	@./scripts/clean.sh


install: clean setup start-monitoring-host start-monitoring start-all
