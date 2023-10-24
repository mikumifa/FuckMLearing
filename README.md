# FuckMLearing

打包

```
docker build metal_env .
```

运行

```
docker run -it --gpus all --name my_metal_container  metal_env
```

docker GPU配置

```
# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

查看可用GPU

```
python -c "import torch; print('GPU IDs:', list(range(torch.cuda.device_count()))) if torch.cuda.is_available() else print('CUDA not available, no GPUs detected.')"
```

