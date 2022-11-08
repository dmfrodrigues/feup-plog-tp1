FROM swipl

COPY . /app
WORKDIR /app

EXPOSE 80
CMD ["./run_server.sh", "80"]
