# Multi-stage Build
FROM alpine:3.8

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache \
    adduser -D flaskapp

WORKDIR /home/flaskapp

RUN pip3.6 install flask gunicorn requests

COPY static static
COPY templates templates
COPY myapp.py wsgi.py ./

RUN chown -R flaskapp:flaskapp ./
USER flaskapp

EXPOSE 8000 
CMD gunicorn -b :8000 -w 4 wsgi:app

#docker build -t flaskapp:latest .
#docker run --name flaskapp -d -p 8000:8000 --rm flaskapp:latest
