FROM debian:11

RUN echo "deb-src http://deb.debian.org/debian bullseye main" >> \
	etc/apt/sources.list

RUN apt update && apt install -y dpkg-dev git-buildpackage

RUN mkdir /packages
