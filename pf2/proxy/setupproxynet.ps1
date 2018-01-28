﻿Import-Module NetAdapter
Import-Module Microsoft.PowerShell.Utility

# Collect networking information for adding a new route to the proxycontainer's route table
$ifIndex = get-netadapter | select -expand ifIndex 
$gatewayIP = get-netroute -DestinationPrefix '0.0.0.0/0' | select -ExpandProperty NextHop
Write-Host "gatewayIP = $gatewayIP"
New-NetRoute –DestinationPrefix "169.254.169.254/32" –InterfaceIndex $ifIndex –NextHop $gatewayIP | Write-Host

# for debugging, print out the routing table contents
route print -4

# testing the access to the MSI

$headers = @{}                                                                                        
$headers["Metadata"] = "`"True`""
Write-Host "Testing access to the  Instance Metadata Service" from the proxy container"
Invoke-WebRequest -Uri "http://169.254.169.254/metadata/instance?api-version=2017-04-02" -Method GET  -Headers $headers -UseBasicParsing" | Write-Host
