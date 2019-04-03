include .env
container=${APP_SLUG}_app
hostpath=${PWD}/${APP_PATH_HOST}

start:
	docker-compose up -d

stop:
	docker-compose stop

up: start
down: stop
restart: stop start

build: clean
	docker-compose build
	docker-compose up -d

rebuild: clean
	docker-compose build --force-rm --no-cache
	docker-compose up -d

clean:
	docker-compose rm -vsf
	docker-compose down -v --remove-orphans

jumpin:
	docker exec -it ${container} bash

composer:
	docker run --rm --interactive --tty \
	-v ${hostpath}:/app \
	-v ${COMPOSER_HOME}:/tmp \
	composer \
	composer i --ignore-platform-reqs

node:
	docker run --rm --interactive --tty \
	-v ${hostpath}:/app \
	-v ${HOME}/.npm:/root/.npm \
	-w="/app" \
	node:lts-alpine \
	npm i

key-gen:
	docker exec ${container} cp .env.example .env && php artisan key:generate -n

migrate:
	docker exec ${container} php artisan migrate -n

migrate-fresh:
	docker exec ${container} php artisan migrate:fresh -n

seed:
	docker exec ${container} php artisan db:seed -n

test:
	docker exec ${container} phpunit

dev: composer node key-gen migrate-fresh
