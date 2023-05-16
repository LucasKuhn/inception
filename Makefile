COMPOSE_FILE := srcs/docker-compose.yml

all: up

up:
	docker compose --file $(COMPOSE_FILE) up --build --detach

down:
	docker compose --file $(COMPOSE_FILE) down

validate:
	docker compose --file $(COMPOSE_FILE) config --quiet

fprune:
	docker system prune --all --force --volumes
