# docker-rclone

# How to run this?
`
docker run -d --network my-bridge --name rclone -v rclone_data:/home/rclone/.config/rclone -p 8080:8080 -e RCLONE_BACKEND_PROTOCOL="restic" -e RCLONE_BACKEND="myremote" -e RCLONE_BACKEND_PATH="/backup" lukasmrtvy/docker-rclone:latest `

# How to create config? 

`docker run --rm -it --network host -v rclone_data:/home/rclone/.config/rclone  -e CONFIG_CREATE="True" lukasmrtvy/docker-rclone:latest /opt/rclone/rclone config 
 `
