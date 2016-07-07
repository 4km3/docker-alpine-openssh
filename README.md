# ssh-jumper
Run an OpenSSH service to be used as a jump host

## Building
```console
$ docker build -t pancho/ssh-jumper .
```
## Configuration
### Default values
```text
: "${LOCAL_USER_ID:=9001}"
: "${LOCAL_USER_NAME:=luser}"
```
### Recommended values
By passing these values when running:
```text
LOCAL_USER_ID=$(id -u $USER)
LOCAL_USER_NAME=$USER
```
you will be able to share both the UID and the user name from the host machine.

## Running
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
    pancho/ssh-jumper
```

## Testing
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
If everything goes OK, you should see something like:
```text
Warning: Permanently added '[localhost]:2222' (ECDSA) to the list of known hosts.
SSH-2.0-OpenSSH_7.2p2-hpn14v4
```
And, upon pressing Enter,
```text
Protocol mismatch.

```

## Sample usage
``` console
$ ssh -i id_ed25519-jumper localhost -p 2222 -W somehost:22
```
## Acknowledgements
Thanks a lot to Raúl Sánchez @rawmind0 for his assistance!
