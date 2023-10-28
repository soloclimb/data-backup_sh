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

if [ ! -e "$config_filename" ]; then
    write_config "Enter a directory path to backed up files: " "BACKUP_DESTINATION"
    write_config "Enter a path to source directory: " "SOURCE"
    write_config "Enter a compression type one of - tar.gz/tar.bz2/zip:" "COMPRESSION_TYPE"
    write_config "Enter a name for backed up files:" "COMPRESSION_FILENAME" 
    write_config "Enter a destination path to backup records .csv file:" "RECORDS_FILE_DESTINATION"
    write_config "Enter a filename to backup records .csv file:" "RECORDS_FILENAME"

    result=$(./check_config.sh "$config_filename")
    echo "$result"
    if [[ $result == "Config was set properly" ]]; then
        echo "\nConfiguration check was successful"
    elif [[ $result == *"must be a directory"* || $result == *"must be one of"* ]]; then
        echo "\nConfiguration check failed: $result"
        rm -f "$config_filename" 
    else 
       echo "\nConfiguration check failed: $result"
        rm -f "$config_filename"  
    fi
fi
