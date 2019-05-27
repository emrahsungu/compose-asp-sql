FROM ubuntu:18.04
RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER docker
CMD /bin/bash

RUN sudo echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf

COPY sshd_config /etc/ssh/
COPY . /app
WORKDIR /app

EXPOSE 80 2222
