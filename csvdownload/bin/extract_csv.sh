#!/bin/bash
cd "`dirname "$0"`"

function dl_process () {
    # Dataloader のプロセスを実行する
    echo process: $1
    java -cp $DATALOADER_CLASSPATH -Dsalesforce.config.dir=$DL_ROOT/conf \
        com.salesforce.dataloader.process.ProcessRunner process.name=$1 # > /dev/null
}

dl_process csvAccountExtractProcess

# cat /opt/dataloader/data/accoutExtract.csv

