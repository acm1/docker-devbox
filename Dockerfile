FROM debian:jessie

ENV HOME /root
ADD build.sh /tmp/
RUN bash /tmp/build.sh

CMD ["tmux"]
