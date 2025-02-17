param (
    [parameter (Mandatory=$true)]
    [string]$VmName,
    [parameter (Mandatory=$true)]
    [string]$SwitchName
)

try {
	set-vmvideo -vmname "$VmName" -horizontalresolution:3440  -verticalresolution:1440 -resolutiontype single
}
catch {
	Write-Host "Failed to set VM's resolution."
}

try {
	set-vm "$VmName" -EnhancedSessionTransportType HVSocket
}
catch {
	Write-Host "Failed to set VM's EnhancedSessionTransportType"
}

try {
  Write-Host "------------------ Configure Node with Powershell Script : $VmName -------------------"
  Write-Host "VM-Machine: $VmName"
  Write-Host "Add Switch: $SwitchName"
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  Write-Host "IsAdmin: " $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
  $vm = Hyper-V\Get-VM -Name $VmName -ErrorAction "stop" 
  Hyper-V\Add-VMNetworkAdapter $vm -Switch $SwitchName  
  Write-Host "------------------ Configuration of Node finished  -------------------"
}
catch {
  Write-Host "Failed to set VM's Second Nic: $_"
}