FROM okazakiyuji/dataloader
MAINTAINER okazakiyuji <zaki@mbf.nifty.com>
WORKDIR $DL_ROOT
ARG PASSWD
ARG SITE
ARG USRNAME 
COPY conf ./conf
COPY bin ./bin
RUN chmod +x ./bin/create_config.sh
RUN chmod +x ./bin/extract_csv.sh
RUN create_config.sh $SITE $USRNAME $PASSWD
CMD ["extract_csv.sh"]

