FROM tekn0ir/nginx-stream:latest
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
