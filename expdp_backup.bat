@echo off
REM ######################################################################
REM #                                                                    #
REM # expdp_backup.bat                                                   #
REM #                                                                    #
REM # Author: Stacey M. Sharp, Jr. (ssharp[AT]thomsonplastics[DOT]com)   #
REM # Version: 2016-01-22                                                #
REM # Description: Oracle/IQMS Database Backup Script                    #
REM #   Performs a Data Pump backup and zips it.                         #
REM #   The file is named with the current date/time.                    #
REM #                                                                    #
REM ######################################################################

REM # Set Variables
SET USER=<USER>
SET PASS=<PASSWORD>
SET DB=<DB>
SET DUMPDRIVE=F
SET DUMPDIR=dump

REM # Capture the current date as YYYYMMDD
FOR /f "tokens=2-8 delims=.:/ " %%G IN ("%DATE%.%TIME%") DO (
SET FILEDATE=%%I-%%G-%%H_%%J-%%K-%%L-%%M
)

SET FILENAME=EXPDP_IQORA_%FILEDATE%

REM # Execute backup
expdp %USER%/%PASS%@%DB% FULL=y DIRECTORY=backups DUMPFILE=%FILENAME%.DMP LOGFILE=%FILENAME%.LOG

REM # ZIP DMP and Log file
%DUMPDRIVE%:
cd \%DUMPDRIVE%
zip -m -1 %FILENAME%.ZIP %FILENAME%.DMP %FILENAME%.LOG

REM # Clear variables
SET FILENAME=
SET FILEDATE=
SET USER=
SET PASS=
SET DB=
SET DUMPDRIVE=
SET DUMPDIR=
