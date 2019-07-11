FROM ubuntu:18.04

LABEL maintainer="jbreed"

# Add configuration folder
ADD config /tmp/

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y apt-utils tzdata 

# port and volume
EXPOSE 8834
VOLUME ["/config"]

# Run installation script
ENTRYPOINT ["/bin/bash", "/tmp/setup.sh"]
