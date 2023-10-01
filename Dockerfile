# ベースイメージを指定
FROM alpine:latest

ENV SCRIPT_FILE=check-calendar-update.sh
ENV SCRIPT_DIR=/app
ENV SCRIPT_PATH=$SCRIPT_DIR/$SCRIPT_FILE

# install packages
RUN apk update && apk add curl

# copy checking script
COPY $SCRIPT_FILE $SCRIPT_PATH
RUN chmod +x $SCRIPT_PATH

# コンテナが起動した際にスクリプトを実行
WORKDIR $SCRIPT_DIR
CMD ["/bin/sh", "-c", "./${SCRIPT_FILE}"]
