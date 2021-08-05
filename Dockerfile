FROM marpteam/marp-cli:latest
# Set to root because marp-cli set user to marp
USER root
RUN apk add --no-cache git gawk m4 sed bc sqlite jpegoptim optipng jq curl perl graphviz gcompat
# Download pandoc
RUN curl -L https://github.com/jgm/pandoc/releases/download/2.14.1/pandoc-2.14.1-linux-amd64.tar.gz > /tmp/pandoc.tar.gz
RUN mkdir /home/marp/bin
RUN tar -xzf /tmp/pandoc.tar.gz -C /home/marp/bin
RUN ln -s /home/marp/bin/pandoc-2.14.1/bin/pandoc /usr/bin/pandoc
# Download binary and post installation
RUN git clone https://github.com/Simhyeon/gdmarp /home/marp/gdmarp
RUN cd /home/marp/gdmarp/modules/wiki/mediawiki/mediawiki_bin && npm install
RUN cd /home/marp/gdmarp/modules/dialogue/gdlogue/gdlogue_bin && npm install
ENTRYPOINT [ "/home/marp/gdmarp/gdmarp", "-c" ]
# Revert to marp
USER marp
