PROJECT_NAME = inception
COMPOSE_FILE = ./srcs/docker-compose.yml

all: up

up:
	docker compose -f $(COMPOSE_FILE) -p $(PROJECT_NAME) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) -p $(PROJECT_NAME) down

clean: down
	docker system prune -f

fclean: down
	docker volume prune -f
	docker system prune -af

re: fclean all

.PHONY: all, clean, fclean, re