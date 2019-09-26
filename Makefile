default: build-9.6

build-9.6:
	docker build ./9.6/. -t madebyais/postgres-slave && \
		docker tag madebyais/postgres-slave:latest madebyais/postgres-slave:9.6.15
