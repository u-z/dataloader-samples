FROM okazakiyuji/dataloader
MAINTAINER okazakiyuji <zaki@mbf.nifty.com>
RUN localedef -f UTF-8 -i ja_JP /usr/lib/locale/ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo"
RUN yum -y install expect
WORKDIR $DL_ROOT
# 
ARG SITE=$SITE
ARG USRNAME=$USRNAME
ARG PASSWD=$PASSWD
COPY conf ./conf
COPY bin ./bin
RUN chmod a+x ./bin/create_config.sh
RUN chmod a+x ./bin/extract_csv.sh
RUN create_config.sh $SITE $USRNAME $PASSWD
RUN cat conf/config.properties
CMD ["extract_csv.sh"]

