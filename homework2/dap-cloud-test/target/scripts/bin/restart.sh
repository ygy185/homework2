#!/bin/bash
cd `dirname $0`
BIN_DIR=`pwd`
cd ..
DEPLOY_DIR=`pwd`
CONF_DIR=$DEPLOY_DIR/conf

SERVER_NAME=`sed '/app.name/!d;s/.*=//' conf/application.properties | tr -d '\r'`
if [ -z "$SERVER_NAME" ]; then 
SERVER_NAME=`sed '/spring.application.name/!d;s/.*=//' conf/application.properties | tr -d '\r'`
fi
if [ -z "$SERVER_NAME" ]; then 
   SERVER_NAME=`sed '/dubbo.application.name/!d;s/.*=//' conf/application.properties | tr -d '\r'`
fi
if [ -z "$SERVER_NAME" ]; then
  echo "ERROR: The app.name or spring.application.name or dubbo.application.name not config!"
  exit 1
fi
SERVER_PORT=`sed '/server.port/!d;s/.*=//' conf/application.properties | tr -d '\r'`

sh stop.sh


COUNT=0
NUM=0
TOTAL=36
while [ $COUNT -lt 1 ]; do    
    echo -e ".\c"
    sleep 1
    if [ -n "$SERVER_PORT" ]; then
        COUNT=`netstat -an | grep $SERVER_PORT | wc -l`
    else
    	COUNT=`ps -ef | grep java | grep "$DEPLOY_DIR" | awk '{print $2}' | wc -l`
    fi
    NUM=`expr $NUM + 1`
    if [ $NUM -eq $TOTAL ]; then
        printf "\n"
        echo "[ERROR]: 应用[$SERVER_NAME]在${TOTAL}s内未能成功停止，请手工检查！！"
        break
    fi
    if [ $COUNT -gt 0 ]; then
        echo -e "Application[$SERVER_NAME] is restarting !"
        sh start.sh
        break
    fi
done

