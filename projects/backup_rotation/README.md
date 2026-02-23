# Backup Script with 5-Day Rotation

This is a **Bash script** to automatically back up a folder, create timestamped backups, and keep only the last 5 days of backups. It can be run manually or automated with cron.

---

## Features

- Creates **timestamped zip backups** of a source directory  
- Automatically **rotates backups**, keeping only the last 5 days  
- Works with directories and files containing spaces  
- Can be automated using cron  

---

## Usage

```bash
./backup.sh <source_directory> <backup_directory>
```
## Example Usage

```bash
./backup.sh /home/ubuntu/backup_rotation/data /home/ubuntu/backup_rotation/backups
```
## Cron Automation

To run the script automatically (e.g., daily at 2 AM), add this line to your crontab:

```bash
0 2 * * * /home/ubuntu/backup_rotation/backup.sh /home/ubuntu/backup_rotation/data /home/ubuntu/backup_rotation/backups
```

Make sure the script is executable:
``` bash
chmod +x backup.sh
```
## Requirements

-Linux / Ubuntu
-zip installed:
```bash
sudo apt install zip -y
```
##How It Works

-Checks if source and backup directories are provided
-Creates a timestamped backup zip in the backup directory
-Deletes backups older than 5 days automatically

## Notes

-The script will create the backup directory if it does not exist
-Can be run multiple times; old backups are rotated
