# Octave Notebook

> by:  [n0b0dy-su](https://github.com/n0b0dy-su)
>

This is a easy way to use [**Octave**](https://www.gnu.org/software/octave/index) on [**jupyter notebook**](https://jupyter.org/install) over a docker [**ubuntu**](https://hub.docker.com/_/ubuntu/) based container, it use the octave kernel of [**Calysto**](https://github.com/Calysto/octave_kernel).

## Prerequisites

- Install Docker, [installation guide](https://docs.docker.com/engine/install/)
- Install Docker-compose, [installation guide](https://docs.docker.com/compose/install/)

## Configuration

In the root forlder you have a [docker-compose.yml](./docker-compose.yml) which defien a structure to build an execute the container, setting the host port 8888 for a forwarding in the 8888 container port, if you have another service running in this port just change the first 8888 for you port election [port configuration](https://docs.docker.com/engine/reference/commandline/port/).

Also have a volume set in the folder [exchange](./exchange) as default, you can modify it to add others volumes or delete it. [docker volumes](https://docs.docker.com/storage/volumes/)

The section command execute the jupyter notebook this is explained in [Usage](##Usage).

```yaml
services:
notebook:
   build:
      dockerfile: octave.Dockerfile
      context: .

       command: jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root
       volumes:
         - ./exchange:/exhange
      ports:
         - 8888:8888
```

The following steps are executed in the [dockerfile](./octave.Dockerfile)

1. Specifies the Ubuntu image on the container

2. Update the index files of ubuntu packages

3. Install python version 3.x.x

4. Install the python package manager for the 3.x.x version 

5. Install jupyter notebook with pip

6. Install the Calysto octave_kernel with pip

```dockerfile
FROM ubuntu

RUN apt-get update
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip3 install notebook
RUN pip3 install octave_kernel
```

## Usage

To execute the container just run

> docker-compose up

This command maybe need root or admin permissions depends of your docker configuration.

If is the first time, you should wait for the build and need a extra step once the it finishes, if the build ends successfully you should see a link something like this

> http://127.0.0.1:8888/?token=<token>

#### Extra step only for the first time

>  - With the container running execute in your console/terminal
>
> ```bash
>   docker container exec -it <container_name> bash
> ```
>
>  - Once in the container bash terminal run
>
>  ```bash
>  apt install octave -y
>  ```
>
>  This step is not in the dockerfile beacuse the installation requires that you set a time zone, language and keyboard layout.
>
>  - When the octave installation finished just run ins the terminal the command
>
>  ```bash  
>  exit
>  ```
>
>  - It is recomended restar the container with <kbd>Ctrl</kbd>+<kbd>c</kbd> and run again
>
>   ```bash
>   docker-compose up
>   ```
>

To use the jupyter notebook, open the link in your browser and it's all.

**NOTE**: if you modify the dockerfile after the first build, the first time after the change you run the container with

```bash
docker-compose up --build
```
