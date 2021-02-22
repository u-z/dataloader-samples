#!/bin/bash
cd "`dirname "$0"`"
CONF_ROOT=$DL_ROOT/conf
KEY_FILE=$DL_ROOT/conf/key.txt
if [ x$DL_ROOT = x ] ; then
    echo データローダのインストールルートを DL_ROOTに設定してください
    exit 1
fi
if [ ! x$3 = x ] ; then
    # 引数に何か設定されていたら環境変数を上書きする
    SITE=$1
    USRNAME=$2
    PASSWD=$3
fi
if [ x$SITE = x -o x$USRNAME = x -o x$PASSWD = x ] ; then
    echo "usage"
    echo "    arg1:site name (ex. login.salesforce.com, test.salesforce.com)"
    echo "    arg2:username"
    echo "    arg3:password"
    exit 1
fi
if [ ! -d $CONF_ROOT ] ; then
    echo $CONF_ROOT を作成してください
    exit 1
fi
if [ -f $KEY_FILE ] ; then
    echo $KEY_FILE を削除します
    rm $KEY_FILE
fi
# 暗号化済パスワードを作成する
java -cp $DATALOADER_CLASSPATH com.salesforce.dataloader.security.EncryptionUtil -k $KEY_FILE
ENC_PW=`java -cp $DATALOADER_CLASSPATH com.salesforce.dataloader.security.EncryptionUtil -e $PASSWD $KEY_FILE | sed -n 2P`
echo "# config.properties" > $CONF_ROOT/config.properties
echo process.encryptionKeyFile=$KEY_FILE >> $CONF_ROOT/config.properties
echo sfdc.endpoint=https://$SITE >> $CONF_ROOT/config.properties
echo sfdc.username=$USRNAME >> $CONF_ROOT/config.properties
echo sfdc.password=$ENC_PW >> $CONF_ROOT/config.properties
echo sfdc.timeoutSecs=600 >> $CONF_ROOT/config.properties
echo sfdc.loadBatchSize=200 >> $CONF_ROOT/config.properties
echo sfdc.extractionRequestSize=500 >> $CONF_ROOT/config.properties
echo sfdc.debugMessages=false >> $CONF_ROOT/config.properties
echo sfdc.debugMessagesFile=/opt/dataloader/status/debug.log >> $CONF_ROOT/config.properties
# Proxy設定の出力　（動作確認未）
if [ x$https_proxy != x ]; then
    PROXY_STR=${https_proxy/*:\/\//}
    WORK=${PROXY_STR%@*}
    if [ x$WORK != x$PROXY_STR ]; then
        echo sfdc.proxyUsername=${WORK%:*} >> $CONF_ROOT/config.properties
        echo sfdc.proxyPassword=${WORK#*:} >> $CONF_ROOT/config.properties
        WORK=${PROXY_STR#*@}
    fi
    echo sfdc.proxyHost=${WORK%:*} >> $CONF_ROOT/config.properties
    echo sfdc.proxyPort=${WORK#*:} >> $CONF_ROOT/config.properties
fi

