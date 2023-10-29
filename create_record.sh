#!/bin/bash

create_record() {
    datetime=`date +"%m-%d-%Y-%H:%M:%S"`
    backup_file="$BACKUP_DESTINATION${COMPRESSION_FILENAME}_($datetime).$COMPRESSION_TYPE"

    if [ ! -f "${RECORDS_FILE_DESTINATION}${RECORDS_FILENAME}.csv" ]; then
        cd "$RECORDS_FILE_DESTINATION" || exit
        touch "${RECORDS_FILENAME}.csv"
        echo "ID, Destination, Source, Compression, Filename" > "${RECORDS_FILE_DESTINATION}${RECORDS_FILENAME}.csv"
        cd -
    fi

    tag=$(tail -n 1 "${RECORDS_FILE_DESTINATION}${RECORDS_FILENAME}.csv")
    tag="${tag%%,*}"
    echo "$((tag + 1)), ${BACKUP_DESTINATION}, ${SOURCE}, ${COMPRESSION_TYPE}, ${backup_file}" >> "${RECORDS_FILE_DESTINATION}${RECORDS_FILENAME}.csv"
}
create_record