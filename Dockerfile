FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers #*.csproj ./
COPY ./ReactAspnet/*.csproj ./
COPY ./ReactAspnetTests/*.csproj ./
RUN dotnet restore ReactAspnet.csproj
RUN dotnet restore ReactAspnetTests.csproj

# Copy everything else and build
#COPY . ./
COPY ./ReactAspnet ./ReactAspnet
COPY ./ReactAspnetTests ./ReactAspnetTests
RUN dotnet build ReactAspnet.sln -c Release --no-restore

RUN dotnet test "./ReactAspnetTests/ReactAspnetTests.csproj" -c Release --no-build --no-restore

RUN dotnet publish ./ReactAspnet/ReactAspnet.csproj -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .
CMD ASPNETCORE_URLS=http://*:$PORT dotnet ReactAspnet.dll
#ENTRYPOINT ["dotnet", "ReactAspnet.dll"]

#FROM microsoft/dotnet:latest

#COPY . /app
#WORKDIR /app  

#CMD ASPNETCORE_URLS=http://*:$PORT dotnet ReactAspnet.dll
#to be placed in publish folder before building docker image