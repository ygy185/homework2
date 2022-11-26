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

PIDS=`ps -ef | grep java | grep "$CONF_DIR" |awk '{print $2}'`
if [ -z "$PIDS" ]; then
    echo "ERROR: The $SERVER_NAME does not started!"
    exit 1
fi

if [ "$1" != "skip" ]; then
    sh $BIN_DIR/dump.sh
fi

echo -e "Stopping the $SERVER_NAME ...\c"
for PID in $PIDS ; do
    kill  $PID >/dev/null 2>&1
done

COUNT=0
NUM=0
TOTAL=60
while [ $COUNT -lt 1 ]; do    
    echo -e ".\c"
    sleep 1
    COUNT=1
    NUM=`expr $NUM + 1`
    if [ $NUM -eq $TOTAL ]; then
        printf "\n"
        echo "[ERROR]: 应用[$SERVER_NAME]在${TOTAL}s内未能成功停止，准备强制停止！！"
        echo -e "force Stop the $SERVER_NAME ...\c"
        for PID in $PIDS ; do
	    	kill -9  $PID >/dev/null 2>&1
		done
        break
    fi
    for PID in $PIDS ; do
        PID_EXIST=`ps -p $PID | grep java`
        if [ -n "$PID_EXIST" ]; then
            COUNT=0
            break
        fi
    done
done
if [ $COUNT -eq 1 ]; then
    echo "OK!"
fi
echo "PID: $PIDS"
