#!/bin/bash
cd "`dirname "$0"`"
if [ x$DL_ROOT = x ] ; then
    DL_ROOT=$DL_BIN_DIR/..
fi
CONF_DIR=$DL_ROOT/conf
function dl_process () {
    # Dataloader のプロセスを実行する
    echo process: $1
    java -cp $DATALOADER_CLASSPATH -Dsalesforce.config.dir=$CONF_DIR \
        com.salesforce.dataloader.process.ProcessRunner process.name=$1 # > /dev/null
}

dl_process csvAccountExtractProcess

cat /opt/dataloader/data/accoutExtract.csv

