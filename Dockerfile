FROM alpine:latest
# gd user is user who interacts with binary
RUN addgroup -S gd && adduser -S gd -G gd
# Root for package install 
USER root
RUN apk add --no-cache nodejs npm git gawk m4 sed bc sqlite jpegoptim optipng jq curl perl graphviz gcompat
RUN git clone https://github.com/Simhyeon/gdmarp /home/gd/gdmarp
RUN cd /home/gd/gdmarp/modules/wiki/mediawiki/mediawiki_bin && npm install
RUN cd /home/gd/gdmarp/modules/dialogue/gdlogue/gdlogue_bin && npm install
# Working directory is called app
RUN mkdir /home/gd/app
WORKDIR /home/gd/app
ENTRYPOINT [ "/home/gd/gdmarp/gdmarp" ]

USER gd
