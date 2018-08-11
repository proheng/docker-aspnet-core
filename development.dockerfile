
FROM microsoft/dotnet:2.1-sdk

LABEL author="Rex Zhiheng He"

ENV DOTNET_USE_POLLING_FILE_WATCHER=1
ENV ASPNETCORE_URLS=http://*:5000

# Avoid using the existing folder
WORKDIR /RexWorkspace

# e.g. docker run  -p 8080:5000 -v C:\Rex\Sandbox\AspNetCore\AspNetCore:/RexWorkspace proheng/aspnetcore:dev
COPY . /RexWorkspace

# CMD ["/bin/bash", "-c", " pwd && dir "]
ENTRYPOINT ["/bin/bash", "-c", "dotnet restore && dotnet watch run"]

