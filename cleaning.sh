while IFS= read -r line; do
    key=${line%%=*}
    value=${line#*=}
    export "$key=$value"

done < "$config_filename"

cd "$BACKUP_DESTINATION" || exit

cleaning() {
    for file in *; do 
}