FROM microsoft/aspnetcore-build:lts
COPY . /app	
WORKDIR /app	
RUN apt-get update \
    && apt-get install -y --no-install-recommends\
        apt-utils\
       unzip\
        openssh-server\
        vim\
        curl\
        wget\
        tcptraceroute\
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /defaulthome/hostingstart \
    && mkdir -p /home/LogFiles/ \
    && echo "root:Docker!" | chpasswd \
    && echo "cd /home" >> /etc/bash.bashrc

COPY init_container.sh ./
RUN chmod 755 init_container.sh

COPY sshd_config /etc/ssh/
COPY ssh_setup.sh /tmp


RUN ["dotnet", "restore"]	
RUN ["dotnet", "build"]	

EXPOSE 80 2222
ENV SSH_PORT 2222


RUN chmod +x ./init_container.sh
CMD /bin/bash ./init_container.sh
