FROM nekorro/rusty-spaghetty:cc89675141636caa39b668d8544dc08dfeb3ffd6
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
