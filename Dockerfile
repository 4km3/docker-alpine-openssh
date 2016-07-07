FROM        alpine:3.4
MAINTAINER  pancho horrillo <pancho@pancho.name>
EXPOSE      22
ENTRYPOINT  [ "/usr/local/sbin/entrypoint" ]
CMD         [ "/usr/sbin/sshd", "-D", "-e" ]

COPY entrypoint /usr/local/sbin/

RUN set -e;                                             \
    passwd -l root;                                     \
    chmod +x /usr/local/sbin/entrypoint;                \
    apk add --no-cache openssh;                         \
    sed -i                                              \
      's/#\(PasswordAuthentication\) yes/\1 no/'        \
      /etc/ssh/sshd_config;
