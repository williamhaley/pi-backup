# Windows

```
powershell (new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/williamhaley/pi-backup/master/client/bootstrap.bat','%TEMP%\bootstrap.bat'); Start-Process "%TEMP%\bootstrap.bat"
```
