@echo off
SETLOCAL

call W:\setenv.bat

:: Directories
set SWC_DIR=swc
set POM_DIR=pom
set REPO_DIR=%USERPROFILE%\.m2\repository

:: Swiz
set SWIZ_SWC=Swiz.swc
set SWIZ_VER=1.3.1
set SWIZ_POM=swiz-%SWIZ_VER%.pom

:: Babel Fx
set BABELFX_SWC=BabelFx.swc
set BABELFX_VER=2.0
set BABELFX_POM=babelfx-%BABELFX_VER%.pom

:: MoveThis
set MOVETHIS_SWC=MoveThis.swc
set MOVETHIS_VER=1.2.0
set MOVETHIS_POM=movethis-%MOVETHIS_VER%.pom

cls
echo -------------------------------------------------------------------------------
echo  INSTALLATION STEPS
echo -------------------------------------------------------------------------------
echo  1. Install BABEL FX into maven repo (%BABELFX_VER%)
echo  2. Install SWIZ into maven repo     (%SWIZ_VER%)
echo  3. Install MOVETHIS into maven repo (%MOVETHIS_VER%)
echo -------------------------------------------------------------------------------
pause

call :print Install Babel Fx into maven repository...
call mvn install:install-file -DgroupId=org.babelfx -DartifactId=babelfx -Dversion=%BABELFX_VER% -Dpackaging=swc -Dfile=%SWC_DIR%/%BABELFX_SWC%

call :print Install Swiz into maven repository...
call mvn install:install-file -DgroupId=org.swizframework -DartifactId=swiz -Dversion=%SWIZ_VER% -Dpackaging=swc -Dfile=%SWC_DIR%/%SWIZ_SWC%

call :print Install MoveThis into maven repository...
call mvn install:install-file -DgroupId=com.hdi.animation -DartifactId=movethis -Dversion=%MOVETHIS_VER% -Dpackaging=swc -Dfile=%SWC_DIR%/%MOVETHIS_SWC%

echo -------------------------------------------------------------------------------
echo  4. Copy BABEL FX pom into maven repo (%BABELFX_POM%)
echo  5. Copy SWIZ pom into maven repo     (%SWIZ_POM%)
echo  6. Copy MOVETHIS pom into maven repo (%MOVETHIS_POM%)
echo -------------------------------------------------------------------------------
pause

set SOURCE=%POM_DIR%\%BABELFX_POM%
set TARGET=%REPO_DIR%\org\babelfx\babelfx\%BABELFX_VER%\
call :cp %SOURCE% %TARGET% %BABELFX_SWC%

set SOURCE=%POM_DIR%\%SWIZ_POM%
set TARGET=%REPO_DIR%\org\swizframework\swiz\%SWIZ_VER%\
call :cp %SOURCE% %TARGET% %SWIZ_SWC%

set SOURCE=%POM_DIR%\%MOVETHIS_POM%
set TARGET=%REPO_DIR%\com\hdi\animation\movethis\%MOVETHIS_VER%\
call :cp %SOURCE% %TARGET% %MOVETHIS_SWC%

call :print DONE
pause

GOTO :eos

:: PRINT MESSAGE
:print
SET MSG=%*
echo.
echo [ %MSG% ]
echo.

GOTO :eos

:: COPY
:cp
::set A=%*
set S=%1
set T=%2
set M=%3
call :print Copy %M% pom file
call copy %S% %T%
::call copy %A%

GOTO :eos

:eos
ENDLOCAL