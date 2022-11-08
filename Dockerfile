FROM ubuntu:20.04

RUN apt update
RUN apt install -y software-properties-common
RUN apt-add-repository ppa:swi-prolog/stable
RUN apt update
RUN apt install -y swi-prolog

COPY . /app
WORKDIR /app

RUN chmod u+x run_server.sh

EXPOSE 80
CMD ["./run_server.sh", "80"]
