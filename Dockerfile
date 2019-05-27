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

COPY sshd_config /etc/ssh/

COPY ssh_setup.sh /tmp

RUN mkdir -p /opt/startup \

   && chmod -R +x /opt/startup \

   && chmod -R +x /tmp/ssh_setup.sh \

   && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null) \

   && rm -rf /tmp/*

COPY . /app	
WORKDIR /app	
RUN ["dotnet", "restore"]	
RUN ["dotnet", "build"]	

EXPOSE 80
ENV SSH_PORT 2222
EXPOSE 8080 2222
RUN chmod +x ./entrypoint.sh	
CMD /bin/bash ./entrypoint.sh	
