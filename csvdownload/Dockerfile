FROM okazakiyuji/dataloader
MAINTAINER okazakiyuji <zaki@mbf.nifty.com>
RUN yum -y install expect
WORKDIR $DL_ROOT
RUN PWD=$PWD
ARG PASSWD
ARG SITE
ARG USRNAME 
COPY conf ./conf
COPY bin ./bin
RUN chmod a+x ./bin/create_config.sh
RUN chmod a+x ./bin/extract_csv.sh
RUN create_config.sh $SITE $USRNAME $PASSWD
CMD ["extract_csv.sh"]

