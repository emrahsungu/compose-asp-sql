FROM microsoft/aspnetcore-build:lts
RUN apt-get update && apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "root:Docker!" | chpasswd 
USER docker
CMD /bin/bash
CMD sudo sysctl -w fs.inotify.max_user_watches=524288
COPY sshd_config /etc/ssh/
RUN sudo apt-get update && sudo apt-get install -y openssh-server
RUN sudo sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config



EXPOSE 80/tcp
EXPOSE 80 2222

CMD /usr/sbin/sshd

