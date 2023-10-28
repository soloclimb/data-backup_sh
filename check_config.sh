#!/bin/bash
config_filename="$1"
check_config() {
    while IFS= read -r line; do
        key=${line%%=*}
        value=${line#*=}
        if [[ "$key" == "BACKUP_DESTINATION" || "$key" == "SOURCE" || "$key" == "RECORDS_FILE_DESTINATION" ]]; then
            if [ ! -d "$value" ]; then 
                echo "$key must be a directory!!\n"
                return 1
            fi
        fi
        if [[ "$key" == "COMPRESSION_TYPE" ]]; then
            if [[ "$value" != "tar.gz" && "$value" != "tar.bz2" && "$value" != "zip" ]]; then 
                echo "$key must be one of  tar.gz/tar.bz2/zip !!\n"
                return 1
            fi
        fi
        export "$key=$value"
        
    echo "Config was set properly"
    return 0
    
    done < "$config_filename"
}
check_config