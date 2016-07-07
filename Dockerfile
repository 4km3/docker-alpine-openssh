FROM        alpine:3.4
MAINTAINER  pancho horrillo <pancho@pancho.name>

LABEL Description="OpenSSH service on Alpine Linux to be used as a jump host"   \
      Vendor="ACME Products"                                                    \
      Version="1.0"

EXPOSE      22
ENTRYPOINT  [ "/usr/local/sbin/entrypoint" ]
CMD         [ "/usr/sbin/sshd", "-D", "-e" ]

COPY entrypoint /usr/local/sbin/

RUN set -e;                                             \
    passwd -l root;                                     \
    apk add --no-cache openssh;                         \
    sed -i                                              \
      's/#\(PasswordAuthentication\) yes/\1 no/'        \
      /etc/ssh/sshd_config;
