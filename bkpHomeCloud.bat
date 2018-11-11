@ECHO OFF

REM ----------- BEGIN CONFIGURATION -----

set FROM_FOLDER=%USERPROFILE%
set TO_FOLDER=REMOTE_USER@SERVER:REMOTE_PATH

set FILES_FILE=%FROM_FOLDER%\.config\backups\cloud\bkpHomeCloud.files
set INCLUDE_FILE=%FROM_FOLDER%\.config\backups\cloud\bkpHomeCloud.include
set EXCLUDE_FILE=%FROM_FOLDER%\.config\backups\cloud\bkpHomeCloud.exclude
set LOG_FILE=%FROM_FOLDER%\.cache\backups\bkpHomeCloud.log

REM NOTE: --files-from disables --recursive in --archive, thus enable explicitly
SET RSYNC_BKP_ARGS=--recursive --archive --hard-links --ignore-errors --delete --compress --partial --human-readable --info=progress2

call :DOS2UNIX %USERPROFILE% HOME_UNIX
SET SSH_ARGS=-F %HOME_UNIX%/.ssh/config -i %HOME_UNIX%/.ssh/id_rsa -o UserKnownHostsFile=%HOME_UNIX%/.ssh/known_hosts

REM ----------- END CONFIGURATION -------

SETLOCAL

REM Change Filenames into Linux Format

call :DOS2UNIX %FROM_FOLDER% FROM_FOLDER_UNIX

call :DOS2UNIX %FILES_FILE% FILES_FILE_UNIX
call :DOS2UNIX %INCLUDE_FILE% INCLUDE_FILE_UNIX
call :DOS2UNIX %EXCLUDE_FILE% EXCLUDE_FILE_UNIX
call :DOS2UNIX %LOG_FILE% LOG_FILE_UNIX

REM Backup Local -> Cloud:

ECHO RSync running...
rsync %RSYNC_BKP_ARGS% --rsh "ssh %SSH_ARGS%" --log-file=%LOG_FILE_UNIX% --files-from=%FILES_FILE_UNIX% --include-from=%INCLUDE_FILE_UNIX% --exclude-from=%EXCLUDE_FILE_UNIX% %FROM_FOLDER_UNIX% %TO_FOLDER%

ECHO Done!

SET PATH=%OLDPATH%
ENDLOCAL
EXIT

:DOS2UNIX
SET DIR=%~1

SET UNIXSLASHDIR=%DIR:\=/%
SET UNIXDIR=/cygdrive/%UNIXSLASHDIR::=%

SET %~2=%UNIXDIR%
goto :EOF
