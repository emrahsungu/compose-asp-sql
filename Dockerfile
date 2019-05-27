FROM microsoft/aspnetcore-build:lts
COPY . /app
WORKDIR /app
RUN apk add openssh \
     && echo "root:Docker!" | chpasswd 
RUN ["dotnet", "restore"]
RUN ["dotnet", "build"]
EXPOSE 80/tcp
EXPOSE 80 2222

RUN chmod +x ./entrypoint.sh
CMD /bin/bash ./entrypoint.sh
