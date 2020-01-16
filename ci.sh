!/bin/bash

if [ "$TRAVIS_PULL_REQUEST" = "true" ] || [ "$TRAVIS_BRANCH" != "master" ]; then
  docker buildx build \
    --progress plain \
    --platform=linux/amd64,linux/386,linux/arm/v7,linux/arm/v6,linux/arm64/v8 \
    --build-arg KNXD_VERSION=$KNXD_VERSION \
    --build-arg KNXD_RELEASE_TAG=$KNXD_RELEASE_TAG \
    .
  exit $?
fi
echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin &> /dev/null
docker buildx build \
    --progress plain \
    --platform=linux/amd64,linux/386,linux/arm/v7,linux/arm/v6,linux/arm64/v8 \
    --build-arg KNXD_VERSION=$KNXD_VERSION \
    --build-arg KNXD_RELEASE_TAG=$KNXD_RELEASE_TAG \
    -t $REPO/$IMAGE_NAME:$KNXD_VERSION
    -t $REPO/$IMAGE_NAME:latest \
    --push \
    .
