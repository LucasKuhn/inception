USER	:= lalex-ku
COMPOSE := srcs/docker-compose.yml
VOLUME_FOLDER := /home/$(USER)/data
ifeq ($(shell uname), Darwin)
	VOLUME_FOLDER := $(HOME)/data
endif

all: up

up:
	docker compose --file=$(COMPOSE) up --build --detach

down:
	docker compose --file=$(COMPOSE) down

config:
	docker compose --file=$(COMPOSE) config

setup:
	mkdir -p $(VOLUME_FOLDER)/wordpress
	mkdir -p $(VOLUME_FOLDER)/mariadb
	grep $(USER) /etc/hosts || echo "127.0.0.1 $(USER).42.fr" >> /etc/hosts

fprune:
	docker system prune --all --force --volumes
