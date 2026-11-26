group "default" {
  targets = ["ubuntu"]
}

target "ubuntu" {
  name   = "ubuntu-${replace(version, ".", "-")}"
  matrix = {
    version = ["22.04", "24.04", "26.04"]
  }
  dockerfile = "Dockerfile"
  args = {
    BASE_IMAGE = "ubuntu:${version}"
  }
  tags = ["bk-dev-docker:ubuntu-${version}"]
}
