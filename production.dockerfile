
# This is a multi-stage docker file
# The commented lines are the VSC generated. It is kept for future reference.
FROM microsoft/aspnetcore:2.0 AS base
WORKDIR /app
EXPOSE 5000

FROM microsoft/aspnetcore-build:2.0 AS build
WORKDIR /src
COPY AspNetCore.csproj AspNetCore/
RUN dotnet restore AspNetCore/AspNetCore.csproj
WORKDIR /src/AspNetCore
COPY . .
RUN dotnet build AspNetCore.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish AspNetCore.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "AspNetCore.dll"]
 


# FROM microsoft/aspnetcore-build as publish-stage
# WORKDIR /publish
# COPY AspNetCore.csproj .
# RUN dotnet restore
# COPY . . 
# RUN dotnet publish --output ./output

# FROM microsoft/aspnetcore
# LABEL author="Rex Zhiheng He"
# WORKDIR /app
# COPY --from=publish-stage /publish/output .
# ENV ASPNETCORE_URLS=http://*:5000
# ENTRYPOINT ["dotnet", "AspNetCore.dll"]