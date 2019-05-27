FROM ubuntu:18.04
RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER docker
CMD /bin/bash

RUN sudo sysctl -w fs.inotify.max_user_watches=524288

COPY sshd_config /etc/ssh/




RUN sudo apt-get update && sudo apt-get install -y openssh-server
RUN sudo mkdir /var/run/sshd
RUN echo 'docker:docker' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


COPY . /app
WORKDIR /app

EXPOSE 80 2222

CMD /usr/sbin/sshd


