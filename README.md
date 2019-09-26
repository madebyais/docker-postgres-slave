docker-postgres-slave
---------------------

A Postgresql replication server in a Docker.

Currently, it is only available for postgresql v9.6. If you need for newer version, please create an issue ticket here https://github.com/madebyais/docker-postgres-slave/issues.

#### GET-STARTED

Before you begin, please make sure that your postgresql master server is ready for `hot_standby` mode. You can follow the tutorial from google:
https://cloud.google.com/community/tutorials/setting-up-postgres-hot-standby

Once you've done with the master, you can docker pull this image and run:

```
docker run -p 5001:5432 --rm \
		-v /Users/ais/Workspace/Engineering/docker/psql-experiment/slave/data:/var/lib/postgresql/data \
		-v /Users/ais/Workspace/Engineering/docker/psql-experiment/slave/tablespace:/var/lib/postgresql/tablespace \
		-e "PG_MASTER_HOST=postgres-master" \
		-e "PG_MASTER_PORT=5432" \
		-e "PG_REPL_USERNAME=repluser" \
		-e "PG_REPL_PASSWORD=qwerty" \
		-e "PG_TABLESPACE_PATH=/var/lib/postgresql/tablespace" \
		--link postgres-master:postgres-master \
		--name postgres-slave madebyais/postgres-slave
```

The `PG_TABLESPACE_PATH` is optional.

If you have any question, you can ping me on github.

#### RELEASED

https://hub.docker.com/r/madebyais/postgres-slave
