FROM marpteam/marp-cli:latest
USER root
RUN apk add --no-cache bash git gawk m4 sed bc sqlite jpegoptim optipng
RUN git clone https://github.com/Simhyeon/gdmarp /home/marp/gdmarp
RUN cd /home/marp/gdmarp && git checkout rusty
ENTRYPOINT [ "/home/marp/gdmarp/gdmarp", "--container" ]
USER marp
