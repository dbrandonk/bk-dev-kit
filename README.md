# bk-dev-kit

Dev environment: a Docker image (`Dockerfile`, `provision.sh`), how it runs
(`docker-compose.yml`), and dotfiles (`configs/`, see [configs/README.md](configs/README.md)).

## Checking the image builds on each Ubuntu version

`docker-bake.hcl` is a build recipe for `docker buildx bake`. 
Docker's built-in tool for running several builds from one file.
It has a matrix over Ubuntu versions, so it expands into one build target per version, and each one builds the `Dockerfile` with a different `BASE_IMAGE`:

| Target         | Base image     | Image tag                    |
|----------------|----------------|------------------------------|
| `ubuntu-22-04` | `ubuntu:22.04` | `bk-dev-docker:ubuntu-22.04` |
| `ubuntu-24-04` | `ubuntu:24.04` | `bk-dev-docker:ubuntu-24.04` |
| `ubuntu-26-04` | `ubuntu:26.04` | `bk-dev-docker:ubuntu-26.04` |

To test build every base images run:
```bash
docker buildx bake
```

