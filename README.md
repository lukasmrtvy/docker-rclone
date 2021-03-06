# docker-rclone

# Info

rclone docker container for backend serving purpose only

# How to run this?
```
docker run -d \
--name rclone \
--network network \
--restart=unless-stopped \
--label "traefik.enable=true" \
--label "traefik.frontend.rule=Host:rclone.example.com" \
--label "traefik.port=8080" \
-e RCLONE_BACKEND_PROTOCOL="restic" \
-e RCLONE_BACKEND="gdrive" \
-e RCLONE_BACKEND_PATH="/backup" \
-e RCLONE_BACKEND_USER=admin \
-e RCLONE_BACKEND_PASS=admin \
-v rclone_data:/home/rclone/.config/rclone \
rclone
```

# How to create config? 

`docker run --rm -it --network host -v rclone_data:/home/rclone/.config/rclone  -e CONFIG_CREATE="True" lukasmrtvy/docker-rclone:latest /opt/rclone/rclone config create myremote drive root_folder_id "1Aw9xxxxxxxxxxxxxxxxxxxxx_Hmg"
 `
 
or

`
docker run --rm -it --network host -v rclone_data:/home/rclone/.config/rclone  -e CONFIG_CREATE="True" lukasmrtvy/docker-rclone:latest /opt/rclone/rclone config
`

# Mandatory config
- /home/rclone/.config/rclone/rclone.conf

# Mandatory variables

- RCLONE_BACKEND_PROTOCOL
- RCLONE_BACKEND

# Env variables

- RCLONE_BACKEND_USER (default: user)
- RCLONE_BACKEND_PASS (default: password)
- RCLONE_BACKEND_PATH (default: /)
- RCLONE_BACKEND_ADDR (default: 0.0.0.0:8080)
- CONFIG_CREATE="True" ( for bypass entrypoint or `--entrypoint sh rclone:latest /opt/rclone/rclone config create `)

or

`-e OVERRIDE_OPTIONS="--user=admin --pass=admin --addr=0.0.0.0:8080"`
