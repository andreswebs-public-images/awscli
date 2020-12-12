# awscli-docker

An [awscli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) docker image for k8s deployment

## Running locally

### Prerequisites:

Set up your [AWS credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) in the `~/.aws/credentials` file. 

Example contents:

```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

**Note:** 

The UID and GID in the image are set to 1000. If your UID and GID are different and you want to mount your credentials file as a volume in the container, you need to rebuild the image passing your correct values as build arguments. 

Example:

``` sh
docker build --tag yourname/awscli --build-arg PUID=1001 --build-arg PGID=1001 .
```

### Run the container:

To run the container with your AWS credentials locally:

``` sh
docker run --rm -it -v ${HOME}/.aws/credentials:/awscli/.aws/credentials:ro --name awscli andreswebs/awscli:latest
```

## Running on kubernetes

### Prerequisites

You need a working k8s cluster and `kubectl` configured.

### Deploy the objects:

``` sh
kubectl apply -f awscli.yml
```

### Attach to the pod:

``` sh
kubectl attach --namespace awscli -ti awscli
```


## Authors

**Andre Silva** [andreswebs](https://github.com/andreswebs)


## License

This project is licensed under the [Unlicense](UNLICENSE.md).


## Acknowledgments

Based on the dockerfiles and configurations by

[Vlad Frolov](https://github.com/frol):

<https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/blob/master/Dockerfile>

and

[Jérôme Petazzoni](https://github.com/jpetazzo):

<https://github.com/jpetazzo/shpod/blob/master/Dockerfile>
