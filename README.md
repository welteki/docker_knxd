[![Docker Pulls](https://img.shields.io/docker/pulls/welteki/knxd.svg)](https://hub.docker.com/r/welteki/knxd)
[![Build Status](https://travis-ci.org/welteki/docker_knxd.svg?branch=master)](https://travis-ci.com/welteki/docker_knxd.svg?branch=master)

automated build with travis-ci

## knxd
For documentation on knxd see the original repository https://github.com/knxd/knxd

### Supported architectures
amd64, arm32v7

> no need to specify architecture during pull

### Supported tags
- `0.14.25`
- `0.14.25-amd64`
- `0.14.25-arm32v7`

### Usage
The container has to be run with --net=host, alternativly u can use the macvlan driver.

**Running knxd**
```
docker run -d --name knxd \
  --host net
  welteki/knxd:0.14.25 \
  knxd -e 1.1.128 -E 0.0.0:8 -D -T -R -S -f 9 -t 1023 -b tpuarts:/dev/ttyAMA0
```

**Creating a knxd config file with `knxd_args`**
```
docker run -rm \
  welteki/knxd:0.14.25 \
  /usr/bin/knxd_args  -e 1.1.128 -E 0.0.0:8 -D -T -R -S -f 9 -t 1023 -b tpuarts:/dev/ttyAMA0 \
  > /knxd/knxd.conf
```

## License
MIT (c) 2018 Han Verstraete https://github.com/welteki
