FROM ubuntu:noble
ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yq && \
  apt-get install -y --no-install-recommends --fix-missing \
  apt \
  apt-transport-https \
  apt-utils \
  curl ca-certificates\
   ffmpeg  exiv2  gifsicle imagemagick libarchive-tools
RUN mkdir /app/
COPY deployments/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
COPY moe-sticker-bot  /app/
ENTRYPOINT ["/entrypoint.sh"]
