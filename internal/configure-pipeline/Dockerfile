FROM "alpine"

LABEL org.opencontainers.image.authors "kratix@syntasso.io"
LABEL org.opencontainers.image.source https://github.com/syntasso/promise-postgresql

RUN [ "mkdir", "/tmp/transfer" ]
RUN apk update && apk add --no-cache yq

COPY resources /tmp/transfer/resources/
COPY dependencies/ /tmp/transfer/dependencies/
ADD execute-pipeline execute-pipeline

CMD [ "sh", "-c", "./execute-pipeline" ]
ENTRYPOINT []
