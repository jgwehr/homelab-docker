cd ~/backup
mkdir $(date +%Y%m%d)

sudo docker exec -t tandoor_db pg_dumpall -U tandoor_user > tandoor_pgdump.sql
