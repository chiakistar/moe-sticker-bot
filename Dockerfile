FROM golang:1.26 AS build
WORKDIR /src
COPY core /src/core
COPY pkg /src/pkg
COPY cmd /src/cmd
COPY go.mod /src/go.mod
COPY go.sum /src/go.sum
RUN  go build -o moe-sticker-bot cmd/moe-sticker-bot/main.go


FROM ubuntu:noble
run mkdir /app/
COPY --from=build /src/moe-sticker-bot /app/
COPY tools/msb_emoji.py /usr/local/bin/msb_emoji.py
COPY tools/msb_rlottie.py /usr/local/bin/msb_rlottie.py
COPY tools/msb_kakao_decrypt.py /usr/local/bin/msb_kakao_decrypt.py

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
ENV PIP_BREAK_SYSTEM_PACKAGES=1

RUN apt-get update -yq && \
  apt-get install -y --no-install-recommends --fix-missing \
  apt \
  python3 python3-pip\
  apt-transport-https \
  apt-utils \
  curl ca-certificates\
   ffmpeg  exiv2  gifsicle imagemagick libarchive-tools
RUN PIP_BREAK_SYSTEM_PACKAGES=1 /usr/bin/pip3 install emoji rlottie-python Pillow
COPY deployments/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
