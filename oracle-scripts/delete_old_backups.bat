REM ############################################################
REM #
REM # delete_old_backups.bat
REM #
REM # Deletes any files in the specified folder that exceeds
REM # 30 days
REM #
REM ############################################################

forfiles /p "f:\dump" /m *.* -d -30 /c "del @path"
