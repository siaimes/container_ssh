chown root:root authorized_keys sshd.sh
docker ps -aq --filter "name=$2" | xargs -r docker rm -f
docker run -itd --name $2 -v ~/container_ssh/authorized_keys:/root/.ssh/authorized_keys -v ~/container_ssh/sshd.sh:/root/sshd.sh --env CONTAINER_SSH_PORT=$3 -p $3:$3 $1
docker exec -it $2 bash /root/sshd.sh
