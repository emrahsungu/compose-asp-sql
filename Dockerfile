FROM microsoft/aspnetcore-build:lts
COPY . /app
WORKDIR /app
RUN ["dotnet", "restore"]
RUN ["dotnet", "build"]
EXPOSE 80/tcp
EXPOSE 80 2222
RUN sysctl fs.inotify.max_user_watches=524288
RUN chmod +x ./entrypoint.sh
CMD /bin/bash ./entrypoint.sh
