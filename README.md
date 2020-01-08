# awscli-docker

An awscli docker image for k8s deployment

## Running locally

### Prerequisites:

Set up your [AWS credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) in the `~/.aws/credentials` file. 

Example contents:

```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

### Run the container:

To run the container with your AWS credentials locally:

`docker run --rm -it -v ${HOME}/.aws/credentials:/root/.aws/credentials:ro --name awscli andreswebs/awscli:latest`


## Running on kubernetes

### Prerequisites

You need a working k8s cluster and `kubectl` configured.

### Deploy the objects:

`kubectl apply -f awscli.yml`

### Attach to the pod:

`kubectl attach --namespace=awscli -ti awscli`


## Authors

**Andre Silva**


## License

This project is licensed under the [Unlicense](UNLICENSE.md).


## Acknowledgments

Based on the dockerfiles and configurations by

[Vlad Frolov](https://github.com/frol):

<https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/blob/master/Dockerfile>

and

[Jérôme Petazzoni](https://github.com/jpetazzo):

<https://github.com/jpetazzo/shpod/blob/master/Dockerfile>