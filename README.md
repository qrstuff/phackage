# phackage

Batteries included [Docker](https://www.docker.com/) image for [PHP](https://www.php.net/) 8.3 + all extensions installed and enabled, [Composer](https://getcomposer.org/), [Node.js](https://nodejs.org/en), [Yarn](https://yarnpkg.com/).

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/qrstuff/phackage/docker-publish.yml?branch=main)

## Security

The `8.x`, `8.x-apache`, and `8.x-fpm` images (including their `-debug` variants) are built from PHP **8.3.36**, which fixes **CVE-2026-109618** and **CVE-2026-109619**. See the [Google Cloud advisory](https://cloud.google.com/blog/products/identity-security/responding-to-core-php-vulnerabilities-cve-2026-109618-cve-2026-109619).

The updated `8.x` images must first be built and published by the workflow. Then pull the updated images, rebuild downstream application images with `--pull`, and redeploy running containers. Existing images and containers are not patched automatically. PHP patch versions are pinned explicitly and must be updated for future security releases.

### PHP 7.x images deprecated

PHP 7.4 is end-of-life and no longer receives security updates. Consequently, phackage has deprecated all `7.x` images, including Apache, FPM, and debug variants, and no longer builds or publishes them.

Existing published `7.x` images remain available unchanged for backward compatibility, but receive no further rebuilds, maintenance, or security updates. They remain vulnerable to the CVEs above. Migrate to the maintained `8.x` images.

## Usage

To use this image, you must have [Docker](https://www.docker.com) installed.

### Inside your [Dockerfile](https://docs.docker.com/engine/reference/builder/#from)

```dockerfile
# use 8.x, 8.x-apache or 8.x-fpm as the image tag
# can suffix tag with -debug for an image with xdebug e.g., 8.x-debug
FROM ghcr.io/qrstuff/phackage:8.x

# ...run, cmd & more
```

### Directly with `docker run`

```shell
# use 8.x, 8.x-apache or 8.x-fpm as the image tag
# again, can suffix tag with -debug for an image with xdebug e.g., 8.x-debug
$ docker run -it --rm -v .:/app -w /app ghcr.io/qrstuff/phackage:8.x composer install

$ docker run -it -p 8000:8000 --rm -v .:/app -w /app ghcr.io/qrstuff/phackage:8.x php artisan serve
```

## Building

Building or modifying the container yourself from source is also quite easy.
Just clone the repository and run below command:

```shell
# using the pinned, patched PHP 8.3.36 base image
$ docker build --pull -t phackage-local .

# using custom php image version/variant
$ docker build --pull --build-arg="baseImageTag=8.3.36-fpm" -t phackage-local .
```

## License

See the [LICENSE](LICENSE) file.

## Notes

From the team at [QRStuff](https://qrstuff.com/) with ❤️ for [Docker](https://www.docker.com/) & [PHP](https://www.php.net/).
