FROM marpteam/marp-cli:latest
USER root
RUN apk add --no-cache git gawk m4 sed bc sqlite jpegoptim optipng jq curl perl graphviz
RUN git clone https://github.com/Simhyeon/gdmarp /home/marp/gdmarp
RUN cd /home/marp/gdmarp/modules/wiki/mediawiki/mediawiki_bin && npm install
RUN cd /home/marp/gdmarp/modules/dialogue/gdlogue/gdlogue_bin && npm install
ENTRYPOINT [ "/home/marp/gdmarp/gdmarp", "-c" ]
USER marp
