I needed to build some binaries _inside_ `Dockerfile` and copy the artifacts built inside the image to the host machine. 

After some digging in, found `buildx` supports [Custom Build Outputs](https://docs.docker.com/engine/reference/commandline/build/#custom-build-outputs) 

Here's an example workflow on how to achieve the same:


```Dockerfile
FROM ubuntu:22.04 AS base

RUN mkdir -p /data
RUN touch /data/hello.txt

# Export the data to host using buildx
FROM scratch AS export
COPY --from=base /data .
```

```bash
docker buildx build --file Dockerfile --output data .
```

After the above command builds the image, you can see `./data` got created in our host machine.

```
.
├── Dockerfile
└── data
    └── hello.txt
```

[Ref](https://stackoverflow.com/questions/33377022/how-to-copy-files-from-dockerfile-to-host)