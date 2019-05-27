FROM ubuntu:18.04

RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER docker
CMD /bin/bash

RUN echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

COPY sshd_config /etc/ssh/
COPY . /app
WORKDIR /app


RUN ["dotnet", "restore"]
RUN ["dotnet", "build"]

EXPOSE 80 2222

RUN chmod +x ./entrypoint.sh
CMD /bin/bash ./entrypoint.sh
