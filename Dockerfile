FROM nekorro/rusty-spaghetty:v0.3.1
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
