IMAGE_ID := "pldin601/web-php-base"

build:
	docker build -t $(IMAGE_ID) .

push:
	docker push $(IMAGE_ID)

run:
	docker run -it --rm -p 8080:8080  $(IMAGE_ID)
