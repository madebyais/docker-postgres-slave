#!/bin/bash

if [ ! -z "PG_TABLESPACE_PATH" ]; then
	echo "[info] Creating tablespace folder path at ${PG_TABLESPACE_PATH} ..."
	mkdir -p ${PG_TABLESPACE_PATH}
	echo "[info] Tablespace folder path is created successfully"
fi

echo "[info] Starting for pg_basebackup, please wait since it may take a while ..."
PGPASSWORD=${PG_REPL_PASSWORD} pg_basebackup -D ${PGDATA} -h ${PG_MASTER_HOST} -p ${PG_MASTER_PORT} -U ${PG_REPL_USERNAME} --xlog-method=stream -v
echo "[info] pg_basebackup process is done"
echo "[info] "

RECOVERY_FILE_PATH=$PGDATA/recovery.conf
echo "[info] Creating recovery.conf file at ${RECOVERY_FILE_PATH} ..."
touch $RECOVERY_FILE_PATH
echo "[info] recovery.conf file created successfully"
echo "[info] "

echo "[info] Adding config into recovery.conf file ..."
echo "standby_mode = on" >> $RECOVERY_FILE_PATH
echo "primary_conninfo = 'host=${PG_MASTER_HOST} port=${PG_MASTER_PORT} user=${PG_REPL_USERNAME} password=${PG_REPL_PASSWORD}'" >> $RECOVERY_FILE_PATH
echo "trigger_file = '/tmp/promot_as_master'" >> $RECOVERY_FILE_PATH
echo "[info] Config added successfully"
echo "[info] "

chown postgres. $PGDATA -R
chmod 700 $PGDATA -R

echo "[info] Enable hot_standby mode in postgresql.conf"
echo "hot_standby = on" >> $PGDATA/postgresql.conf
echo "[info] hot_standby mode enabled"
echo "[info] "

echo "[info] Please wait for the replication server to be started ..."

exec "$@"
