#!/bin/bash
config_filename="./backups_config.txt"
result=$(./check_config.sh "$config_filename")
echo "$result"
if [[ $result == "Config was set properly" ]]; then
    echo "\nConfiguration check was successful"
elif [[ $result == *"must be a directory"* || $result == *"must be one of"* ]]; then
    echo "\nConfiguration check failed: $result"
    rm -f "$config_filename" 
else 
    echo "Configuration check failed: $result"
    rm -f "$config_filename"  
fi
while IFS= read -r line; do
    key=${line%%=*}
    value=${line#*=}
    export "$key=$value"
done < "$config_filename"
backup() {
    datetime=`date +"%m/%d/%Y/%H:%M"`
    backup_file="$BACKUP_DESTINATION/$COMPRESSION_FILENAME.$COMPRESSION_TYPE"
    if [ -d "$SOURCE" ]; then
        if [ "$COMPRESSION_TYPE" == "tar.gz" ]; then
            tar -czvf "$backup_file" -C "$SOURCE" .
        elif [ "$COMPRESSION_TYPE" == "tar.bz2" ]; then
            tar -cjvf "$backup_file" -C "$SOURCE" .
        else 
            cd "${SOURCE%/*}" || exit
            zip -r "$backup_file" "${SOURCE##*/}"
            cd -
        fi

    elif [ -f "$SOURCE" ]; then
        if [ "$COMPRESSION_TYPE" == "tar.gz" ]; then
            tar -czvf "$backup_file" -C "${SOURCE%/*}" "${SOURCE##*/}"
        elif [ "$COMPRESSION_TYPE" == "tar.bz2" ]; then
            tar -cjvf "$backup_file" -C "${SOURCE%/*}" "${SOURCE##*/}"
        else 
            cd "${SOURCE%/*}" || exit
            zip -9 "$backup_file" "${SOURCE##*/}"
            cd -
        fi
        tar -czvf "$backup_file" -C 
    fi
}
backup