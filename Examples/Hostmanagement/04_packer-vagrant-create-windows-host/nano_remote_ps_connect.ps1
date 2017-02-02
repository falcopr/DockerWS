# https://msdn.microsoft.com/en-us/library/mt708806%28v=vs.85%29.aspx
$ip = "127.0.0.1"  # replace with your Nano Server's IP address
$port = 55985
# New-PSSession -ComputerName "127.0.0.1" -Port 55985 -Credential vagrant
$s = New-PSSession -ComputerName $ip -Port $port -Credential vagrant

# Copy-Item -ToSession $s -Path C:\PowerShell\Tools\* -Destination c:\Tools -Recurse
# Copy-Item -FromSession $s -Path C:\Windows\Logs\DISM\dism.log -Destination C:\PowerShell

Copy-Item -ToSession $s -Path ./docker.zip -Destination c:\Windows\setup\docker 
Copy-Item -ToSession $s -Path ./certs/* -Destination C:\ProgramData\docker\certs.d
