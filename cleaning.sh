config_filename="./backups_config.txt"

while IFS= read -r line; do
    key=${line%%=*}
    value=${line#*=}
    export "$key=$value"
done < "$config_filename"

del=`find "$BACKUP_DESTINATION" -type f -ctime +$RETENTION_PERIOD -delete`

