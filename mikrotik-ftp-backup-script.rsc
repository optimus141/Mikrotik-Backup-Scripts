# Get current date and time
:local curDate [/system clock get date]
:local curTime [/system clock get time]
# Clean up the date and time (replace spaces and colons)
:local dateClean [:pick $curDate 0 3]
:set dateClean ($dateClean . [:pick $curDate 4 6])
:set dateClean ($dateClean . [:pick $curDate 7 11])
:local timeClean [:pick $curTime 0 2]
:set timeClean ($timeClean . [:pick $curTime 3 5])
:set timeClean ($timeClean . [:pick $curTime 6 8])
# Build the backup filename
:local backupName ("backup_" . $dateClean . "_" . $timeClean)
:local backupFile ($backupName . ".backup")
# FTP credentials
:local ftpServer "ip_here"
:local ftpUser "ftp_username_here"
:local ftpPassword "password_here"
:local ftpFolder "/path_here/"
# Create the backup
/system backup save name=$backupName
# Upload the backup to FTP
/tool fetch address=$ftpServer src-path=$backupFile user=$ftpUser password=$ftpPassword \
    mode=ftp upload=yes dst-path=($ftpFolder . $backupFile)
# Optional: delete local backup file after upload
#/file remove $backupFile