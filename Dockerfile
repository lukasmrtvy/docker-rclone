FROM alpine:3.8

ENV UID 1337
ENV GID 1337
ENV USER rclone
ENV GROUP rclone

ENV VERSION=1.43.1

RUN   addgroup -S ${GROUP} -g ${GID} && adduser -D -S -u ${UID} ${USER} ${GROUP} && \ 
      apk update && apk add --no-cache curl unzip bash && \ 
      mkdir -p /opt/rclone /home/${USER}/.config/rclone/ && \
      curl  -L https://github.com/ncw/rclone/releases/download/v${VERSION}/rclone-v${VERSION}-linux-amd64.zip -o /tmp/rclone-v${VERSION}-linux-amd64.zip && \
      unzip /tmp/rclone-v${VERSION}-linux-amd64.zip -d /tmp/ && \
      cd /tmp/rclone-* &&  cp -r . /opt/rclone && \
      chown ${USER}:${GROUP} -R /opt/rclone /home/${USER}/.config/rclone/ && \
      rm -rf /tmp/

COPY /scripts/entrypoint.sh /

RUN chmod +x entrypoint.sh

WORKDIR /opt/rclone

USER rclone

EXPOSE 8080

VOLUME /home/${USER}/.config/rclone/

ENTRYPOINT ["/entrypoint.sh"]

CMD ["sh","-c","/opt/rclone/rclone serve \"${RCLONE_BACKEND_PROTOCOL}\" --pass \"${RCLONE_BACKEND_PASS}\"  --addr \"${RCLONE_BACKEND_ADDR}\"  \"${RCLONE_BACKEND_PASS}\" \"${RCLONE_BACKEND_ADDR}\" \"${RCLONE_BACKEND}\":\"${RCLONE_BACKEND_PATH}\" "]
