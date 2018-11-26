#.net core process
FROM microsoft/dotnet:sdk AS builder
WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_10.x |  bash -
RUN apt-get install -y nodejs

COPY ./ReactAspnet/*.csproj ./
RUN dotnet restore ReactAspnet.csproj
COPY ./ReactAspnet ./
RUN dotnet build ReactAspnet.csproj -c Release --no-restore

#React process
#FROM node:10.13.0-alpine as node
#WORKDIR /app
#COPY ./ReactAspnet/bin/release/netcoreapp2.1/publish/wwwroot ./wwwroot
#COPY ./ReactAspnet/bin/release/netcoreapp2.1/publish/package*.json ./
#RUN npm install --progress=true --loglevel=silent
#RUN npm run build

RUN dotnet publish ReactAspnet.csproj -c Release -o out --no-restore

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=builder /app/out .
CMD ASPNETCORE_URLS=http://*:$PORT dotnet ReactAspnet.dll
#ENTRYPOINT ["dotnet", "ReactAspnet.dll"]

#FROM microsoft/dotnet:latest

#COPY . /app
#WORKDIR /app  

#CMD ASPNETCORE_URLS=http://*:$PORT dotnet ReactAspnet.dll
#to be placed in publish folder before building docker image