<p align="center"><img src="https://laravel.com/assets/img/components/logo-homestead.svg"></p>

## Sindria/Homestead

A fork of laravel/homestead for every php environment. Develop by Sindria Inc.: [https://sindria.org](https://sindria.org).

Laravel Homestead is an official, pre-packaged Vagrant box that provides you a wonderful development environment without requiring you to install PHP, a web server, and any other server software on your local machine. No more worrying about messing up your operating system! Vagrant boxes are completely disposable. If something goes wrong, you can destroy and re-create the box in minutes!

Homestead runs on any Windows, Mac, or Linux system, and includes the Nginx web server, PHP 7.2, MySQL, Postgres, Redis, Memcached, Node, and all of the other goodies you need to develop amazing Laravel applications.

Official documentation [is located here](https://laravel.com/docs/homestead).


## Supported

- Laravel
- Symfony
- Zend Framework
- Yii
- Magento 1.x
- Magento 2.x
- WordPress

## Coming

- Joomla
- Drupal 

## Installation

`composer require sindria/homestead --dev`

Mac / Linux:

`php vendor/bin/homestead make`

Windows:

`vendor\\bin\\homestead make`


## Available options for Homestead.yml

Usage: `type: <platform>` 

- Laravel = [default no key needed]

- Symfony = `type: symfony`

- Zend Framework = `type: zend`

- Yii = `type: yii`

- Magento 1.x = `type: magento1`

- Magento 2.x = `type: magento2`

- WordPress = `type: wordpress`


#### Append options:

- Enable mariadb `mariadb: true`

- Enable sindria for custom provision `sindria: true`

- Enable WSL compatibility `wsl: true`


### Example

```
ip: "10.249.197.10"
memory: 2048
cpus: 1
provider: virtualbox

authorize: ~/.ssh/vagrant@homestead.pub

keys:
    - ~/.ssh/vagrant@homestead

folders:
    - map: ~/projects/<appname>
      to: /var/www/<appname>

sites:
    - map: <appname>
      to: /var/www/<appname>/public
      type: "magento2"

databases:
    - homestead
name: <appname>
hostname: <appname>
mariadb: true
sindria: true
wsl: false

```


##### Mysql credentials:

Database - homestead

DB_User - homestead

DB_Pass - secret

