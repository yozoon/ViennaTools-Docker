# Pre-Configured Docker Image for Creating Applications using ViennaTools

## Requirements

This project requires a working installation of Docker (and docker compose), which can be obtained from [docker.com](https://www.docker.com/).

## Building the Image

> If you only want to use the image, you can skip this step.

To build the image, simply run the following command
```bash
docker compose build --progress=plain
```

Depending on your internet connection, this could take a while, since overall about 3GB of packages have to be downloaded and installed in the container image (mostly [VTK](https://vtk.org/) and [embree](https://www.embree.org/) as well as their dependencies).

The image can then be exported for distribution using the following command:

```bash
docker save docker-viennatools:latest > viennatools.tar
```

Or directly compress the image file as it is being written using gzip:

```bash
docker save docker-viennatools:latest | gzip > viennatools.tar.gz
```

## Using a pre-built Image

The fastest way to get started is by using a pre-built image.
```bash
docker load < viennatools.tar
```

The _docker load_ command also supports loading of compressed image files, such as _*.tar.gz_. A full list of supported compression algorithms can be found [here](https://docs.docker.com/engine/reference/commandline/load/).

```bash
docker load < viennatools.tar.gz
```

## Running the Image

Once the image has been built or loaded, running the application is achieved by executing the following command:

```bash
docker compose up
```

This starts the docker container and mounts the _project_ and _output_ folder to the container. Then the CMake project in the _project_ folder is configured and compiled using the _output_ folder as a build directory. Finally the _run.sh_ script is called. All outputs that are generated in the build directory (i.e. the _output_ folder) will persist even after the container shuts down again.

A simple example project is provided in the _project_ directory, which can be used as a starting point for developing your own applications using _ViennaTools_. Just make sure that the executable(s) you defined within the project's CMakeLists file are also called in the run.sh shell script.

> Even though the executable(s) are generated in the _output_ directory, they most likely won't work on your host machine, since they require libraries from within the Docker container. Thus, if you want to run an executable, make sure that it is called in the _run.sh_ script!  
