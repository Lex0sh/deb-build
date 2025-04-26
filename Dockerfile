FROM debian:latest

RUN echo "deb http://deb.debian.org/debian/ stable main contrib" > \
	/etc/apt/sources.list && \
	echo "deb-src http://deb.debian.org/debian/ stable main contrib" >> \
	/etc/apt/sources.list && \
	rm /etc/apt/sources.list.d/debian.sources

RUN apt update && apt install -y dpkg-dev git-buildpackage

RUN mkdir /packages
