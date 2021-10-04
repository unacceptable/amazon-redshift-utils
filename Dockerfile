FROM python:alpine

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/src/app
COPY ["src/", "."]
RUN find "$PWD" -name "*.sh" -or -name "*.py" -print -exec chmod +x "{}" ";"

RUN apk add libpq \
        postgresql-client \
        gcc \
        libxml2 \
        libxslt \
        findutils

RUN find "$PWD" \
        -name "requirements.txt" \
        -not -path "*libxml2*" \
        -printf "INSTALLING REQUIREMENTS: %p\n" -exec pip install -r "{}" ";"

ENTRYPOINT ["/usr/src/app/bin/entrypoint.sh"]
