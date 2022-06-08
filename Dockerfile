FROM python:3-alpine

LABEL maintainer='Rui Ma'
LABEL version='1.0.0-build.1'

ADD . /code
WORKDIR /code
RUN \
  apk add --no-cache libc-dev libffi-dev gcc && \
  pip install -r requirements.txt --no-cache-dir && \
  apk del gcc libc-dev libffi-dev && \
  addgroup webssh && \
  adduser -Ss /bin/false -g webssh webssh && \
  chown -R webssh:webssh /code

EXPOSE 8888/tcp
USER webssh
CMD ["python", "run.py", "--address=0.0.0.0", "--port=8888", "--xsrf=False"]
