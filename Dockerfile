FROM swipl

COPY . /app
WORKDIR /app

RUN chmod u+x run_server.sh

EXPOSE 80
CMD ["./run_server.sh", "80"]
