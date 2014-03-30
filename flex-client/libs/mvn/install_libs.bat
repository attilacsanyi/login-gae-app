@echo off

echo ---------------------------------------------
echo  Install Babel Fx into maven repository
echo ---------------------------------------------
pause
@call mvn install:install-file -DgroupId=org.babelfx -DartifactId=babelfx -Dversion=2.0 -Dpackaging=swc -Dfile=../Framework_BabelFx.swc
echo ---------------------------------------------
echo  Babel Fx installation is done
echo ---------------------------------------------
pause

echo ---------------------------------------------
echo  Install Swiz into maven repository
echo ---------------------------------------------
pause
@call mvn install:install-file -DgroupId=org.swizframework -DartifactId=swiz -Dversion=1.2.0 -Dpackaging=swc -Dfile=../swiz-framework-v1.2.0.swc
echo ---------------------------------------------
echo  Swiz installation is done
echo ---------------------------------------------
pause