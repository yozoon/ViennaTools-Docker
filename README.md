# Pre-Configured Docker Image for Creating Applications using ViennaTools

## Requirements

This project requires a working installation of Docker (and docker compose), which can be obtained from [docker.com](https://www.docker.com/).

## Building the Image

You can find the instructions [here](ViennaTools/README.md).

## Usage

The fastest way to get started is by using a pre-built image. This can be accomplished by running the following command:

```bash
docker run -v "$PWD"/project/:/mnt/project -v "$PWD"/output/:/mnt/output yozoon/viennatools:latest
```

This starts the docker container and mounts the _project_ and _output_ folder to the container. Then the CMake project in the _project_ folder is configured and compiled using the _output_ folder as a build directory. Finally the _run.sh_ script is called. All outputs that are generated in the build directory (i.e. the _output_ folder) will persist even after the container shuts down again.

A simple example project is provided in the _project_ directory, which can be used as a starting point for developing your own applications using _ViennaTools_. Just make sure that the executable(s) you defined within the project's CMakeLists file are also called in the run.sh shell script.

> Even though the executable(s) are generated in the _output_ directory, they most likely won't work on your host machine, since they require libraries from within the Docker container. Thus, if you want to run an executable, make sure that it is called in the _run.sh_ script!  
