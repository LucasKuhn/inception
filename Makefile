LOGIN	:= lalex-ku
COMPOSE	:= srcs/docker-compose.yml

# Change this path to store volumes in another place
export VOLUMES_PATH	:= /home/$(LOGIN)/data

all: srcs/.env up

up:
	docker compose --file=$(COMPOSE) up --build --detach

down:
	docker compose --file=$(COMPOSE) down

config:
	docker compose --file=$(COMPOSE) config

srcs/.env:
	@echo "Missing .env file in srcs folder" && exit 1

fprune:
	docker system prune --all --force --volumes

setup:
	mkdir -p $(VOLUMES_PATH)/wordpress
	mkdir -p $(VOLUMES_PATH)/mariadb
	grep $(LOGIN) /etc/hosts || echo "127.0.0.1 $(LOGIN).42.fr" >> /etc/hosts
