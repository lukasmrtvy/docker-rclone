FROM alpine:3.9

ENV UID 1337
ENV GID 1337
ENV USER rclone
ENV GROUP rclone

ENV VERSION=1.48.1

RUN   addgroup -S ${GROUP} -g ${GID} && adduser -D -S -u ${UID} ${USER} ${GROUP} && \ 
      apk add -U --no-cache curl unzip && \ 
      mkdir -p /opt/rclone /home/${USER}/.config/rclone/ && \
      curl  -L https://github.com/ncw/rclone/releases/download/v${VERSION}/rclone-v${VERSION}-linux-amd64.zip -o /tmp/rclone-v${VERSION}-linux-amd64.zip && \
      unzip /tmp/rclone-v${VERSION}-linux-amd64.zip -d /tmp/ && \
      cd /tmp/rclone-* &&  cp -r . /opt/rclone && \
      chown ${USER}:${GROUP} -R /opt/rclone /home/${USER}/.config/rclone/ && \
      apk del curl unzip
      rm -rf /tmp/

COPY /scripts/entrypoint.sh /

RUN chmod +x entrypoint.sh

WORKDIR /opt/rclone
USER rclone
EXPOSE 8080

VOLUME /home/${USER}/.config/rclone/

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/opt/rclone/rclone" , "serve" , "${RCLONE_BACKEND_PROTOCOL}"  , "--user" ,"${RCLONE_BACKEND_USER}" , "--pass" , "${RCLONE_BACKEND_PASS}" , "--addr" , "${RCLONE_BACKEND_ADDR}" , "${RCLONE_BACKEND_OPTIONS}" , "${RCLONE_BACKEND}:${RCLONE_BACKEND_PATH}" ]
