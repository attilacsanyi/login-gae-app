@echo off

:: Call specific environmnet settings (maven, etc.)
@call W:\setenv.bat

:: Install and deploy the source
@call mvn clean install -Dmaven.test.skip=true
@call cd server
@call mvn gae:deploy -Dmaven.test.skip=true