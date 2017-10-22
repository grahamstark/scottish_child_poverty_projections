#
# backup just the model schemas and copy to backup dir, demo server and laptop
#
WORK_DIR=$SCP/model/tmp/
BACK_DIR=/mnt/backup/local_backups/scottish_child_poverty_projections/
DATE_FORMAT=`date '+%d_%m_%Y'`
DUMP_FILE=$WORK_DIR/ukds_target_schema_$DATE_FORMAT.sql

echo "creating postgres dump file |$DUMP_FILE|"
pg_dump -U postgres ukds -n target_data > $DUMP_FILE

echo "b-zipping $DUMP_FILE"
bzip2 $DUMP_FILE

echo "making local backup; writing to $BACK_DIR"
cp $DUMP_FILE.bz2 $BACK_DIR

echo "copying to laptop"
scp $DUMP_FILE.bz2 Latitude-3330:

echo "copying to projectsvr"
scp $DUMP_FILE.bz2 projectsvr.virtual-worlds-research.com: