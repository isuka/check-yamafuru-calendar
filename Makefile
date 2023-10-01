
CONTAINER_NAME=check-yamafuru

all: clean build run

build:
	docker-compose build

run: build
	docker-compose up -d

ps:
	docker-compose ps

login:
	docker exec -it --detach-keys ctrl-\\ ${CONTAINER_NAME} bash

stop:
	docker-compose down

clean:
	docker-compose down --rmi all

