# phackage

Batteries included [Docker](https://www.docker.com/) image for latest [PHP](https://www.php.net/) 7 & 8 versions + all extensions installed and enabled, [Composer](https://getcomposer.org/), [Node.js](https://nodejs.org/en), [Yarn](https://yarnpkg.com/).

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/qrstuff/phackage/docker-publish.yml?branch=main)

## Usage

To use this image, you must have [Docker](https://www.docker.com) installed.

### Inside your [Dockerfile](https://docs.docker.com/engine/reference/builder/#from)

```dockerfile
# you can use any of 7.4, 7.4-apache, 7.4-fpm, 8.3, 8.3-apache or 8.3-fpm as image tag
# can suffix tag with -debug for an image with xdebug e.g., php-8.3-debug
FROM ghcr.io/qrstuff/phackage:7.4

# ...run, cmd & more
```

### Directly with `docker run`

```shell
# you can use any of 7.4, 7.4-apache, 7.4-fpm, 8.3, 8.3-apache or 8.3-fpm as image tag
# again, can suffix tag with -debug for an image with xdebug e.g., php-8.3-debug
$ docker run -it --rm -v .:/app -w /app ghcr.io/qrstuff/phackage:7.4 composer install

$ docker run -it -p 8000:8000 --rm -v .:/app -w /app ghcr.io/qrstuff/phackage:7.4 php artisan serve
```

## Building

Building or modifying the container yourself from source is also quite easy.
Just clone the repository and run below command:

```shell
# using latest php
$ docker build -t phackage-local .

# using custom php image version/variant
$ docker build --build-arg="baseImageTag=7.4-cli" -t phackage-local .
```

## License

See the [LICENSE](LICENSE) file.

## Notes

From the team at [QRStuff](https://qrstuff.com/) with ❤️ for [Docker](https://www.docker.com/) & [PHP](https://www.php.net/).
