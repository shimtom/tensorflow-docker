# Tensorflow Docker

## Intorduction
### English
This is container that provides pyenv, anaconda, tensorflow and jupyter.
`latest` tag is tensorflow only cpu version, and `latest-gpu` tag is tensorflow gpu version.
Python2 and python3 is available in both tag.
When you run this container, jupyter launches.
Default password of jupyter is `JUPYTER_PASS`. You can change this password by setting env variable `PASSWORD`.  

## Usage
```
$ docker run -it -p 8888:8888 -e PASSWORD=somepassword shimtom/tensorflow:latest-gpu
```
