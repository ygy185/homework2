@echo off & setlocal enabledelayedexpansion

set LIB_JARS=""
cd ..\lib
for %%i in (*) do set LIB_JARS=!LIB_JARS!;..\lib\%%i
cd ..\bin

if ""%1"" == ""debug"" goto debug
if ""%1"" == ""jmx"" goto jmx

java -Xms324m -Xmx1024m  -classpath ..\conf;%LIB_JARS%   com.dap.cloud.b2o.B2OApplication

goto end

:debug
java -Xms128m -Xmx512m  -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -classpath ..\conf;%LIB_JARS% mainClass
goto end

:jmx
java -Xms256m -Xmx1024m -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -classpath ..\conf;%LIB_JARS%   com.dap.cloud.BootstrapApplication

:end
pause