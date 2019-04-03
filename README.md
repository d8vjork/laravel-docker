![](https://img.shields.io/badge/laravel-5.8-orange.svg) ![](https://img.shields.io/badge/php-7.1-blue.svg) ![](https://img.shields.io/badge/prod-not%20ready-red.svg) ![](https://img.shields.io/badge/dev-ready-green.svg)

# Laravel + Docker = ❤️

A simple Laravel preset for use Docker as a wrapper of it (forgot the idea of use php serve/artisan serve anymore).

## Purpose

The main idea is try to help people integrate Docker in their local environment and jump into the production environment without big jumps (aka fridays headaches).

**Important!** Don't try this first if you're not familiar with Docker and/or you don't even have it installed in your computer.

## Installation

Clone this repo into your project's folder.

Next copy the _.env.example_ to _.env_ (the one of the root folder), and change the `APP_SLUG` for something that will be used to prefix all the containers of your app.

Finally run `make build`, and enjoy!

**Important!** For complete the installation you may run `make dev` once the build fires up the services, read above for more info.

### Windows

On windows, as always, requires extra steps. You need to install [chocolatey](https://chocolatey.org/install) from your PowerShell or CMD (**check the link for more information**).

And install make using this (a ported one from GNU): 

```
choco install make
```

### Configuration

All the configuration is based in one single _.env_ file (the root one) **except for the `APP_KEY`**, this one is on the Laravel application folder otherwise you can't regenerate it using the artisan CLI (which is generated by `make key-gen`).

Add the rest of the Laravel _.env_ configuration key-values on the root _.env_ file using `APP_*` and don't forget to copy them and pass all on the _docker-compose.yml_ file (**on the php service**).

## Folder structure

- application : Root folder for your Laravel application
- docker : Folder for all the Docker services files

## Makefile

Makefile is the best tool where you can use whatever you want, the idea is to simplify the learning curve without those big commands when we always spend some time finding for guides. 

```
make build - Build application container and run all the services
make rebuild - Rebuild application container without any cache (REMOVE EVERYTHING)
make start - Start all the services
make stop - Stop all the services

make jumpin - Go to the Terminal of the application container
make seed - Run seeders from your Laravel application
make test - Run phpunit tests in your application container
make dev - Install all the dependencies needed for the application

make up - Alias of start
make down - Alias of stop
make restart - Run a down/up
```

If you need more, you can always digging deeper into the [Makefile](https://github.com/d8vjork/laravel-docker/blob/master/README.md).

## Extras

On [the wiki](https://github.com/d8vjork/laravel-docker/wiki) you'll found much more useful stuff.
