#.net core process
FROM microsoft/dotnet:sdk AS builder
WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_10.x |  bash -
RUN apt-get install -y nodejs

COPY ./ReactAspnet/*.csproj ./
RUN dotnet restore ReactAspnet.csproj
COPY ./ReactAspnet ./
RUN dotnet build ReactAspnet.csproj -c Release --no-restore

RUN dotnet publish ReactAspnet.csproj -c Release -o out --no-restore

FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=builder /app/out .
CMD ASPNETCORE_URLS=http://*:$PORT dotnet ReactAspnet.dll
#ENTRYPOINT ["dotnet", "ReactAspnet.dll"]