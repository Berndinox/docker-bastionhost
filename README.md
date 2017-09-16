# docker-bastionhost

Controll your Docker Containers via Shell from inside another Docker Container!
This will give you some Security enhancements, you can just controll docker (as root), but inside a jailed Conaiter!

Just RUN via:
```
docker run -d -p IP-TO-PUBLISH:22:22 -e PASSWORD=MySecret -v /etc/localtime:/etc/localtime:ro -v /var/run/docker.sock:/var/run/docker.sock berndinox/docker-bastionhost
```

or via compose:
```
version: '3.2'

services:
  ssh:
    image: berndinox/docker-bastionhost
    deploy:
      replicas: 1
    ports:
      - "IP:22:22"
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock
      - data:/data
    environment:
      - PASSWORD=SECRET

volumes:
  data:
    driver: DRIVER
    driver_opts:
      mountpoint: /data
```

Per default OTP is enabled, but without pergenerated Google Auth config. So, any connection attemps will fail per default
So ouy have to:
```
docker exec -it DOCKERID google-authenticator
```
to generate the config and be able to scan the QR


