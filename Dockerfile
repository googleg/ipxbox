FROM alpine:latest
RUN apk update
RUN apk add go libpcap-dev 
RUN mkdir $HOME/go
RUN export GOPATH=$HOME/go && go install github.com/fragglet/ipxbox@trunk
RUN mv $HOME/go/bin/ipxbox /usr/bin/ipxbox
RUN rm -rf /go.mod /go.sum $HOME/go $HOME/.cache $HOME/.config/go
#RUN sed -i 's/module(load="imklog")/# module(load="imklog")/g' /etc/rsyslog.conf
#COPY run.sh /run.sh

ENV PORT=10000
ENV EXTRA_PARAMS=""

CMD ["/bin/sh", "-c", "/usr/bin/ipxbox -port $PORT -logging=stdout $EXTRA_PARAMS"]
