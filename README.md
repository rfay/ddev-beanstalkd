[![tests](https://github.com/drud/ddev-beanstalkd/actions/workflows/tests.yml/badge.svg)](https://github.com/drud/ddev-beanstalkd/actions/workflows/tests.yml)

## What is this?

This repository allows you to quickly install [beanstalkd](https://beanstalkd.github.io/) into a [Ddev](https://ddev.readthedocs.io) project using just `ddev get drud/ddev-beanstalkd`.

## Installation

1.`ddev get drud/ddev-beanstalkd && ddev restart`

## Caveats

The `schickling/beanstalkd` image used here is amd64 only, and will not work with arm64 computers like the Mac M1.

## Explanation

This beanstalkd recipe for [ddev](https://ddev.readthedocs.io) installs [`.ddev/docker-compose.beanstalkd.yaml`](docker-compose.beanstalkd.yaml) which usees the `schickling/beanstalkd` docker image. Note that this image seems to be unmaintained and does not work with Mac M1 (arm64) computers. PRs to use a more recent image are welcome, and especially if they're maintained and support both amd64 and arm64.

## Interacting with beanstalkd

* The beanstalkd instance will listen on TCP port 11300 (the beanstalkd default).
* Configure your application to access beanstalkd on the host:port `beanstalkd:11300`.
* To reach the beanstalkd admin interface, run ddev ssh to connect to the web container, then use nc or telnet to connect to the beanstalkd container on port 11300, i.e. nc beanstalkd 11300. 
