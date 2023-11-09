.PHONY: docker-exec docker-up docker-down

docker-exec:
	docker exec -ti terraform-container bash

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down

