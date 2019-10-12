FROM ruby:2.5.1-stretch
FROM thefirstflame/rad

# Change to the application's directory
WORKDIR /application

ADD . /application

# Make all the files accessible
RUN chmod -R 777 *

RUN useradd -u 10012 -g sudo appuser

USER appuser

# Start the application server
CMD ["/bin/bash", "-c", "set -e && ./entrypoint.sh"]

# docker run --network="host" -it --env-file=.env --cap-add SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro --group-add lrun --privileged --rm csp

