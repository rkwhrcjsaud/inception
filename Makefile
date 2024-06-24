YML_PATH=srcs/docker-compose.yml
DATA_PATH=/home/${USER}/data

all: build up

build:
	docker compose -f ${YML_PATH} build

up:
	docker compose -f $(YML_PATH) up -d

stop:
	docker compose -f $(YML_PATH) stop

start:
	docker compose -f $(YML_PATH) start

restart: clean all

clean:
	docker compose -f $(YML_PATH) down -v

fclean: clean
	sudo rm -rf $(DATA_PATH)/*/*
	docker system prune -af
