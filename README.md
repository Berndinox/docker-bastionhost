# docker-bastionhost

Controll your Docker Containers via Shell from inside another Docker Container!
This will give you some Security enhancements, you can just controll docker (as root), but inside a jailed Conaiter!
```
docker run -d -p IP-TO-PUBLISH:22:22 -e PASSWORD=MySecret -v /etc/localtime:/etc/localtime:ro -v /var/run/docker.sock:/var/run/docker.sock berndinox/docker-bastionhost
```

Goot luck, have fun!
TODO: Implement Google OTP

