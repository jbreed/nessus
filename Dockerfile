FROM ubuntu:18.04

LABEL maintainer="justin.s.breed@gmail.com"

ADD Nessus-8.5.1-ubuntu1110_amd64.deb /tmp/Nessus-8.5.1-ubuntu1110_amd64.deb

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y apt-utils tzdata \
	&& dpkg -i /tmp/Nessus-8.5.1-ubuntu1110_amd64.deb \
	&& rm -r /tmp/Nessus-8.5.1-ubuntu1110_amd64.deb

EXPOSE 8834

CMD service nessusd start && tail -f /dev/null

# Command to build: docker build -t jbreed/nessus .
# Command to start: docker run -d --name nessus-8 -p 8834:8834 jbreed/nessus
# Command to update to dockerhub: docker push jbreed/nessus:latest