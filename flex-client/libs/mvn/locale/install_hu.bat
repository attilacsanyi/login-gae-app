@echo off
SET FLEX_VERSION=4.5.0.19786
SET LOCALE=hu_HU

echo ---------------------------------------------
echo  Install Flex %FLEX_VERSION% with %LOCALE% locale
echo ---------------------------------------------
pause
SET SWC_NAME=advancedgrids
@call mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE%/%SWC_NAME%_rb.swc
SET SWC_NAME=charts
@call mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE%/%SWC_NAME%_rb.swc
SET SWC_NAME=framework
@call mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE%/%SWC_NAME%_rb.swc
SET SWC_NAME=mx
@call mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE%/%SWC_NAME%_rb.swc
SET SWC_NAME=osmf
@call mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE%/%SWC_NAME%_rb.swc
SET SWC_NAME=rpc
@call mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE%/%SWC_NAME%_rb.swc
SET SWC_NAME=spark
@call mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE%/%SWC_NAME%_rb.swc
SET SWC_NAME=textLayout
@call mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE%/%SWC_NAME%_rb.swc
SET SWC_NAME=flash-integration
@call mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE%/%SWC_NAME%_rb.swc
SET SWC_NAME=playerglobal
@call mvn install:install-file -DgroupId=com.adobe.flex.framework -DartifactId=%SWC_NAME% -Dclassifier=%LOCALE% -Dversion=%FLEX_VERSION% -Dpackaging=rb.swc -Dfile=%LOCALE%/%SWC_NAME%_rb.swc

echo ---------------------------------------------
echo  Install %LOCALE% locale is done
echo ---------------------------------------------
pause
