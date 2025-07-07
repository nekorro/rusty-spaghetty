FROM nekorro/rusty-spaghetty:73197a96411a1971aa84292550c18355bfee35d4
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
