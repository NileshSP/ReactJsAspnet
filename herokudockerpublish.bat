REM - This file assumes that you have access to the application and that you have docker installed
REM : Setup your applications name below
SET APP_NAME="reactjsaspnetcoresql"

REM - Delete all files and folders in publish
del /q ".\ReactAspnet\bin\Release\netcoreapp2.1\publish\*"
FOR /D %%p IN (".\ReactAspnet\bin\Release\netcoreapp2.1\publish\*.*") DO rmdir "%%p" /s /q

dotnet clean --configuration Release
dotnet publish -c Release
copy Dockerfile .\ReactAspnet\bin\Release\netcoreapp2.1\publish\
cd .\bin\Release\netcoreapp2.1\publish\
call heroku login
call heroku container:push web -a %APP_NAME%
call heroku container:release web -a %APP_NAME%


::heroku publish commands
::create heroku app using browser using login
::using heroku CLI in the root directory of the project
::heroku login
::heroku git:remote -a reactjsaspnetcoresql
::heroku buildpacks:set https://github.com/jincod/dotnetcore-buildpack
::heroku buildpacks:add --index 1 heroku/nodejs
::heroku buildpacks -- check for registered buildpacks for the repository/project
::git subtree push --prefix ReactAspnet heroku master    OR    git push heroku master

:: heroku buildpacks:add --index 1 heroku/nodejs