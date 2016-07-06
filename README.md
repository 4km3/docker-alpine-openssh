# ssh-jumper
Run an OpenSSH service to be used as a Jump Host

Add some actual pub keys to $PWD/authorized_keys, 
and then run the container like this:
```console
$ docker run                                                            \
    -d                                                                  \
    -p 2222:22                                                          \
    --name ssh-jumper                                                   \
    -e LOCAL_USER_NAME="${USER}"                                        \
    -e LOCAL_USER_ID=$(id -u "${USER}")                                 \
    -v $PWD/authorized_keys:/home/"${USER}"/.ssh/authorized_keys:ro     \
    ssh-jumper
```

We find it useful to use these settings for repeatedly testing the ssh-jumper container:
```console
$ ssh                                   \
    -o StrictHostKeyChecking=no         \
    -o UserKnownHostsFile=/dev/null     \
    -i id_ed25519-jumper                \
    -p 2222                             \
    localhost                           \
    -W localhost:22
```

Thanks a lot to Raúl Sánchez @rawmind0 for his assistance!
