This is a `Microsoft Windows` batch script that backs up

- all those files and folders in a source folder (that defaults to the home folder `%USERPROFILE%`) that are listed in `./backup2cloud.files`,
- except those listed in `./backup2cloud.exclude`

via `rsync` to a destination folder on a remote server.

# Installation

1. Clone this repository, for example into `%USERPROFILE%\Downloads`
    ```sh
    cd %USERPROFILE%\Downloads\
    git clone https://github.com/konfekt/backup2cloud.bat
    ````
0. Copy `backup2cloud.bat` into a convenient folder, for example, `%USERPROFILE%\bin`
    ```sh
    copy %USERPROFILE%\Downloads\backup2cloud.bat\backup2cloud.bat %USERPROFILE%\bin\
    ```
0. Copy `.\backup2cloud.files` and  `.\backup2cloud.exclude` to `%USERPROFILE%\.config\backups\cloud` by
    ```sh
    cd %USERPROFILE%\Downloads\backup2cloud.bat
    md %USERPROFILE%\.config\backups\cloud
    cp .\backup2cloud.files %USERPROFILE%\.config\backups\cloud\
    cp .\backup2cloud.exclude %USERPROFILE%\.config\backups\cloud\
    ```
    and adapt the files and folders listed in them to those that suit you.
0. Inside `backup2cloud.bat`, replace

    - `REMOTE_USER` by your user name to log in to the `rsync` server
    - `SERVER` by the address of the `rsync` server, and
    - `REMOTE_PATH` by the path of your folder on the `rsync` server.

# Caveats

This `batch` script assumes that the folder where the `rsync` executable lies in is part of the `%PATH%` environment variable.
A convenient program to set `%PATH%` is [Rapidee](http://www.rapidee.com/).
Otherwise, replace `rsync` by the full path of of the `rsync` executable.

The variant of `rsync` for `Microsoft Windows` used is [cwRsync Free](https://itefix.net/cwrsync).
Be aware that versions `> 5.4.1` do no longer respect the `%HOME%` environment variable.
Therefore, the full paths to all configuration files of `ssh`, namely `config`, `known_hosts` and the private key `id_rsa` have to be passed to `rsync`.
This `batch` script assumes that they lie in the folder `%USERPROFILE%\.ssh`.

