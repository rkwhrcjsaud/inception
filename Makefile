YML_PATH=srcs/docker-compose.yml
DATA_PATH=/home/${USER}/data
DOMAIN=gibkim.42.fr
IP=127.0.0.1


all: check build up

check:
	@if [ ! -d $(DATA_PATH)/wordpress ]; then\
		mkdir -p $(DATA_PATH)/wordpress;\
	fi
	@if [ ! -d $(DATA_PATH)/mariadb ]; then\
		mkdir -p $(DATA_PATH)/mariadb;\
	fi
	@if ! grep -q $(DOMAIN) /etc/hosts; then\
		echo $(IP) $(DOMAIN) | sudo tee -a /etc/hosts > /dev/null;\
	fi

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
