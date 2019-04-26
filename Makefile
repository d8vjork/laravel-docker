-include .env
container=${APP_SLUG}_app
hostpath=${PWD}/${APP_PATH_HOST}
.DEFAULT_GOAL := help

help: ## Print the help page
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |\
	cut -d ':' -f 2 -f 3 |\
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

up: ## Start Docker services
	@docker-compose up -d

start: up ## Alias of up

down: ## Stop Docker services
	@docker-compose stop

stop: down ## Alias of down

restart: stop start ## Restart Docker services

jumpin: ## Jump into the application container
	@docker exec -it ${container} bash

build: ## Builds the application
	@docker-compose build --no-cache
	$(MAKE) up

rebuild: clean ## Rebuilds the application cleaning everything (no cache)
	@docker-compose build --force-rm --no-cache
	@docker-compose up -d

clean: ## Clean docker with volumes
	@docker-compose rm -vsf
	@docker-compose down -v --remove-orphans

composer: ## Setup PHP (composer) dependencies
	@docker run --rm --interactive --tty \
	-v ${hostpath}:/app \
	-v ${COMPOSER_HOME}:/tmp \
	composer \
	composer i --ignore-platform-reqs

npm: ## Setup Node (npm) dependencies
	@docker run --rm --interactive --tty \
	-v ${hostpath}:/app \
	-v ${HOME}/.npm:/root/.npm \
	-w="/app" \
	node:lts-alpine \
	npm i

key-gen: ## Generate a new Laravel key
	@docker exec ${container} cp .env.example .env && php artisan key:generate -n

migrate: ## Run migrate on Laravel artisan
	@docker exec ${container} php artisan migrate -n

migrate-fresh: ## Run migrate:fresh on Laravel artisan
	@docker exec ${container} php artisan migrate:fresh -n

seed: ## Run db:seed on Laravel artisan
	@docker exec ${container} php artisan db:seed -n

test: ## Run phpunit tests of your application
	@docker exec ${container} phpunit

dev: composer npm key-gen migrate-fresh ## Setup the development environment
