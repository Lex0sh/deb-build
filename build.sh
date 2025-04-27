#!/bin/bash
set -x
# Autobuilder deb packages with gbp.

#-------------------------------------------------------------------------------
# Variables.

id_docker_image="$(docker images -q debuilder:v1)"

#-------------------------------------------------------------------------------
# Checking the parameters.

if [ $# -le 0 ]; then
	echo "Enter a name software for build deb package and version"
	exit 1
fi

#-------------------------------------------------------------------------------
# Checking the built docker image or building it.

if [ -z "$id_docker_image" ]; then
	docker build . --tag=debuilder:v1
fi

#-------------------------------------------------------------------------------
# Checking the packages/ directory or create it.

if [ ! -d "packages" ]; then
	mkdir packages
fi

#-------------------------------------------------------------------------------
# Starting a container.

id_docker_image="$(docker images -q debuilder:v1)"

docker container run \
	--rm \
	--name="build-$1" \
	-v "$(pwd)/packages":/packages \
	"$id_docker_image" \
	/bin/bash -c \
	"cd packages && \
	mkdir $1 && \
	cd $1 && \
	apt source $1=$2 && \
	cd $1-$2 && \
	apt-get build-dep -y . && \
	debuild"

#-------------------------------------------------------------------------------
