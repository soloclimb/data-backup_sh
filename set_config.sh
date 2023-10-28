#!/bin/bash
config_filename="./backups_config.txt"
write_config() {
    quest="$1"
    key="$2"
    value=""

    echo "$quest"
    read value

    if [ ! -f "$config_filename" ]; then
        touch "$config_filename"
    fi
    if [ -n "$value" ]; then
        echo "${key}=${value}" >> "$config_filename"
    fi
}

check_config() {
    while IFS= read -r line; do
        key=${line%%=*}
        value=${line#*=}
        if [[ "$key" == "BACKUP_DESTINATION" || "$key" == "SOURCE" || "$key" == "RECORDS_FILE_DESTINATION" ]]; then
            if [ ! -d "$value" ]; then 
                echo "{$key} must be a directory!!"
            fi
        fi
        if [[ "$key" == "COMPRESSION_TYPE" ]]; then
            if [[ "$value" != "tar.gz" && "$value" != "tar.bz2" && "$value" != "zip" ]]; then 
                echo "$key must be one of  tar.gz/tar.bz2/zip !!"
            fi
        fi
        export "$key=$value"
        
    echo "Config was set properly"

    done < "$config_filename"
}

if [ ! -e "$config_filename" ]; then
    write_config "Enter a directory path to backed up files: " "BACKUP_DESTINATION"
    write_config "Enter a path to source directory: " "SOURCE"
    write_config "Enter a compression type one of - tar.gz/tar.bz2/zip:" "COMPRESSION_TYPE"
    write_config "Enter a name for backed up files:" "COMPRESSION_FILENAME" 
    write_config "Enter a destination path to backup records .csv file:" "RECORDS_FILE_DESTINATION"
    write_config "Enter a filename to backup records .csv file:" "RECORDS_FILENAME"

    check_config
fi
