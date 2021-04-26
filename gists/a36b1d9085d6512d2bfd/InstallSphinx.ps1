$source = "https://www.python.org/ftp/python/3.4.3/python-3.4.3.amd64.msi"
$destination = "c:\Python34\python-3.4.3.amd64.msi"

Write-Host "Downloading Python..."
mkdir C:\Python34
Invoke-WebRequest $source -OutFile $destination
Write-Host "Download complete. Installing Python..."
msiexec /i c:\Python34\python-3.4.3.amd64.msi TARGETDIR=C:\Python34 /qn | Out-Null
Write-Host "Installation complete."
$env:Path += ";C:\Python34;C:\Python34\Scripts"
Write-Host "Installing SPHINX..."
pip install sphinx | Out-Null
Write-Host "SPHINX installation complete."