FROM alpine

RUN apk --update --no-cache add varnish && \
echo "Success."

COPY ./default.vcl /etc/varnish/default.vcl

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

ENV VARNISH_MEMORY 64M

EXPOSE 80
CMD ["/start.sh"]
