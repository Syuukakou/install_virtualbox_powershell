# Install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install virtualbox from chocolatey
choco install -y virtualbox

# Add VirtualBox to environment path in order to use VBoxManage command line
$env:PATH = $env:PATH + ";C:\Program Files\Oracle\VirtualBox"
