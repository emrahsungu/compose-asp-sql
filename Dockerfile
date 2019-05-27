FROM microsoft/aspnetcore-build:lts

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

COPY init_container.sh /bin/
RUN chmod 755 /bin/init_container.sh

COPY sshd_config /etc/ssh/
COPY ssh_setup.sh /tmp

COPY . /app	
WORKDIR /app	
RUN ["dotnet", "restore"]	
RUN ["dotnet", "build"]	

EXPOSE 80 2222


RUN chmod +x /bin/init_container.sh
CMD /bin/bash /bin/init_container.sh
