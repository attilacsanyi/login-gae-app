@echo off
SETLOCAL

:: mvn is in the path

SET FLEX_VERSION=4.5.0.19786
SET LOCALE_HU_HU=hu_HU
SET LOCALE_EN_US=en_US
SET FB_DIR=c:\Program Files\Adobe\Adobe Flash Builder 4.5
SET SDK_DIR=%FB_DIR%\sdks\4.5.0
SET M2_REPO=c:\Documents and Settings\Attila_Csanyi\.m2\repository
SET SWC_FILES=advancedgrids,charts,framework,mx,osmf,rpc,spark,textLayout,flash-integration,playerglobal
SET LOCALE_HU_HU_DIR=%SDK_DIR%\frameworks\locale\%LOCALE_HU_HU%
SET LOCALE_EN_US_DIR=%SDK_DIR%\frameworks\locale\%LOCALE_EN_US%

echo  ---------------------------------------------
echo   Copy locales from en_US to hu_HU
echo  ---------------------------------------------
CALL %SDK_DIR%/bin/copylocale %LOCALE_EN_US% %LOCALE_HU_HU%
pause

echo  ---------------------------------------------
echo   Copy other required files from en_US
echo  ---------------------------------------------
CALL copy %LOCALE_EN_US_DIR%/flash-integration_rb.swc %LOCALE_HU_HU_DIR%/flash-integration_rb.swc
CALL copy %LOCALE_EN_US_DIR%/playerglobal_rb.swc %LOCALE_HU_HU_DIR%/playerglobal_rb.swc
pause

echo  ---------------------------------------------
echo   Install Flex %FLEX_VERSION% with %LOCALE_HU_HU% locale
echo  ---------------------------------------------
CALL :parse "%SWC_FILES%"
pause

GOTO :eos

:: PARSING FILES
:: -----------------------------------------------------------------------------
:parse

SET LIST=%1
SET LIST=%LIST:"=%

FOR /f "tokens=1* delims=," %%a IN ("%LIST%") DO (
  IF NOT "%%a" == "" CALL :install %%a
  IF NOT "%%b" == "" CALL :parse "%%b"
)
GOTO :eos

:: INSTALLING SWC FILE
:: -----------------------------------------------------------------------------
:install
SET SWC_NAME=%1
@CALL mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE_HU_HU% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE_HU_FILE_DIR%/%SWC_NAME%_rb.swc

GOTO :eos

:eos
ENDLOCAL