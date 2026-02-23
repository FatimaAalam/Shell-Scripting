#!/bin/bash

: << readme


Backup script with 5 day rotation
Usage:
./backup.sh <source_path> <backup_path>
readme


display_usage() {
    echo "Usage: ./backup.sh <source_path> <backup_path>"
}

if [ $# -ne 2 ]; then
    display_usage
    exit 1
fi

source_dir=$1
backup_dir=$2
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

create_backup() {
    mkdir -p "${backup_dir}"
    zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null

    if [ $? -eq 0 ]; then
        echo "Backup generated successfully for ${timestamp}"
    else
        echo "Backup failed"
        exit 1
    fi
}

perform_rotation() {
    backups=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))

    if [ "${#backups[@]}" -gt 5 ]; then
        echo "Performing rotation for 5 days"

        backup_to_delete=("${backups[@]:5}")
        echo "Deleting old backups: ${backup_to_delete[@]}"

        for file in "${backup_to_delete[@]}"; do
            rm -f "$file"
        done
    fi
}

create_backup
perform_rotation
