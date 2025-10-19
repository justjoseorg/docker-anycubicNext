# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

LABEL maintainer="justjoseorg"

# title
ENV TITLE=AnycubicSlicerNext \
    NO_GAMEPAD=true

RUN \
  echo "**** install packages ****" && \
  add-apt-repository ppa:xtradeb/apps && \
  echo "deb [trusted=yes] https://cdn-universe-slicer.anycubic.com/prod $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/acnext.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install --no-install-recommends -y \
    firefox \
    gstreamer1.0-alsa \
    gstreamer1.0-gl \
    gstreamer1.0-gtk3 \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-pulseaudio \
    gstreamer1.0-qt5 \
    gstreamer1.0-tools \
    gstreamer1.0-x \
    libgstreamer-plugins-bad1.0 \
    libwebkit2gtk-4.1-0 \
    libwx-perl && \
  echo "**** Install Anycubic slicer latest ****" && \
  apt install -y anycubicslicernext && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /config/.launchpadlib \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# ports and volumes
EXPOSE 3001
VOLUME /config
VOLUME /tmp
