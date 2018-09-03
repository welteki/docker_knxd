amd64:
		cp Dockerfile.cross Dockerfile.amd64
		sed -i "s|__BASEIMAGE_ARCH__|amd64|g" Dockerfile.amd64
		sed -i "s|__VERSION__|$(VERSION)|g" Dockerfile.amd64
		cat Dockerfile.amd64
		docker build -f Dockerfile.amd64 --no-cache -t $(REPO)/$(IMAGE_NAME):$(VERSION)-amd64 .
		docker push $(REPO)/$(IMAGE_NAME):$(VERSION)-amd64

arm32v7:
		cp Dockerfile.cross Dockerfile.arm32v7
		sed -i "s|__BASEIMAGE_ARCH__|armv7hf|g" Dockerfile.arm32v7
		sed -i "s|__VERSION__|$(VERSION)|g" Dockerfile.arm32v7
		cat Dockerfile.arm32v7
		docker build --build-arg ARCH=arm32v7 --no-cache -f Dockerfile.arm32v7 -t $(REPO)/$(IMAGE_NAME):$(VERSION)-arm32v7 .
		docker push $(REPO)/$(IMAGE_NAME):$(VERSION)-arm32v7

tag:
		docker pull $(REPO)/$(IMAGE_NAME):$(VERSION)-amd64
		docker pull $(REPO)/$(IMAGE_NAME):$(VERSION)-arm32v7
		./docker-linux-amd64 -v 
		./docker-linux-amd64 manifest create $(REPO)/$(IMAGE_NAME):$(VERSION) $(REPO)/$(IMAGE_NAME):$(VERSION)-amd64 $(REPO)/$(IMAGE_NAME):$(VERSION)-arm32v7 -a
		./docker-linux-amd64 manifest inspect $(REPO)/$(IMAGE_NAME):$(VERSION)
		./docker-linux-amd64 manifest annotate $(REPO)/$(IMAGE_NAME):$(VERSION) $(REPO)/$(IMAGE_NAME):$(VERSION)-amd64
		./docker-linux-amd64 manifest annotate $(REPO)/$(IMAGE_NAME):$(VERSION) $(REPO)/$(IMAGE_NAME):$(VERSION)-arm32v7 --os linux --arch arm
		./docker-linux-amd64 manifest push $(REPO)/$(IMAGE_NAME):$(VERSION)

latest:
		docker pull $(REPO)/$(IMAGE_NAME):$(LATEST)-amd64
		docker pull $(REPO)/$(IMAGE_NAME):$(LATEST)-arm32v7
		./docker-linux-amd64 -v 
		./docker-linux-amd64 manifest create $(REPO)/$(IMAGE_NAME):latest $(REPO)/$(IMAGE_NAME):$(LATEST)-amd64 $(REPO)/$(IMAGE_NAME):$(LATEST)-arm32v7 -a
		./docker-linux-amd64 manifest inspect $(REPO)/$(IMAGE_NAME):latest
		./docker-linux-amd64 manifest annotate $(REPO)/$(IMAGE_NAME):latest $(REPO)/$(IMAGE_NAME):$(LATEST)-amd64
		./docker-linux-amd64 manifest annotate $(REPO)/$(IMAGE_NAME):latest $(REPO)/$(IMAGE_NAME):$(LATEST)-arm32v7 --os linux --arch arm
		./docker-linux-amd64 manifest push $(REPO)/$(IMAGE_NAME):latest
