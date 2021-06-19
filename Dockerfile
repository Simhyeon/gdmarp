FROM marpteam/marp-cli:latest
USER root
RUN apk add --no-cache git awk m4 sed bc sqlite jpegoptim optipng
RUN git clone https://github.com/Simhyeon/gdmarp /home/marp/gdmarp
ENTRYPOINT [ "/home/marp/gdmarp/gdmarp", "--container" ]
USER marp
