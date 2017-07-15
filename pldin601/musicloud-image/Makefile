IMAGE_ID := "pldin601/musicloud-image"

build:
	docker build -t $(IMAGE_ID) .

push:
	docker push $(IMAGE_ID)

run:
	docker run --rm -p 8080:8080  $(IMAGE_ID)
