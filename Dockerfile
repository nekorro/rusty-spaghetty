FROM nekorro/rusty-spaghetty:d8335f21622a5f63d3abe9218829e8de74ac19ce
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
