# Start the ssh service in the container for remote login.

## Usage

## Clone Repository

```bash
git clone https://github.com/siaimes/container_ssh.git
cd container_ssh
chmod +x *.sh
```

### Add Public Key

Add your own public key to `authorized_keys`, one public key per line.

### Start Containers

Run the following command to start a container

```bash
sudo ./container.sh pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel pytorch110 8022
```

The first parameter is the image name, the second parameter is the container name, and the third parameter is the port.

Now you can use the root user, server IP and port you provided for ssh login.

You can modify `container.sh` yourself or make a copy to add your own parameters, such as mounting gpu, limiting cpu and memory, etc.
