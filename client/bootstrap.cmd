bitsadmin.exe /transfer "GetCygwin" https://cygwin.com/setup-x86.exe setup-x86.exe

setup-x86.exe ^
--download ^
--site http://cygwin.mirror.constant.com ^
--no-admin ^
--no-shortcuts ^
--no-desktop ^
--quiet-mode ^
--root %APPDATA%\cygwin
--local-package-dir %APPDATA%\cygwin-packages ^
--packages ^
openssh ^
git ^
rsync ^
nano ^
