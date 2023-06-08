set -o errexit
set -o nounset
set -o pipefail

apt update && apt install openssh-server -y

SSH_DIR=/root/.ssh

function prepare_ssh()
{
  mkdir -p ${SSH_DIR}
  chmod 700 ${SSH_DIR}
  touch ${SSH_DIR}/authorized_keys
  chmod 644 ${SSH_DIR}/authorized_keys

  mkdir -p /var/run/sshd

  # Set sshd config
  sed -i 's/[# ]*PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
  sed -i 's/[# ]*Port.*/Port '$CONTAINER_SSH_PORT'/' /etc/ssh/sshd_config
  echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config

  sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

  echo "sshd:ALL" >> /etc/hosts.allow

}

function start_ssh()
{
  printf "%s %s\n" \
    "[INFO]" "start ssh service"
  service ssh restart
}

if [ -f /usr/sbin/sshd ] ; then
    prepare_ssh
    start_ssh
else
    echo "no sshd binary found" >&2
fi
