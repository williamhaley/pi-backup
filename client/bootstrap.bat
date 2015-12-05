REM Powershell 2
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cygwin.com/setup-x86.exe', 'setup-x86.exe')"

REM Powershell 3
REM powershell -Command "Invoke-WebRequest https://cygwin.com/setup-x86.exe -OutFile setup-x86.exe"

setup-x86.exe ^
--site http://cygwin.mirror.constant.com ^
--no-shortcuts ^
--no-desktop ^
--quiet-mode ^
--root "%PROGRAMFILES%\cygwin" ^
--arch x86 ^
--local-package-dir "%PROGRAMFILES%\cygwin-packages" ^
--verbose ^
--prune-install ^
--packages ^
openssh ^
git ^
rsync ^
nano

setx path "%PATH%;%PROGRAMFILES%\cygwin\bin"

del setup-x86.exe
