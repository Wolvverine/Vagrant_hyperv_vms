@echo off
REM Change Password !!!
SET SMBPASSWORD=test_password

REM # Environment Variables for Vagrant

SET pwdvar=%cd%

REM Set environment variables
set VAGRANT_DEFAULT_PROVIDER=hyperv
set VAGRANT_HOME=%pwdvar%

REM Write environment variables to registry
setx VAGRANT_DEFAULT_PROVIDER hyperv /m
setx VAGRANT_HOME %pwdvar% /m

echo %VAGRANT_DEFAULT_PROVIDER%
echo %VAGRANT_HOME%

echo "Make shared folder for Vagrant VMs"
mkdir "%pwdvar%\shared"

echo "Add user for vagrant share"
net user Vagrant %SMBPASSWORD% /add /y

echo "Share folder for Vagrant VMs"
net share vagrant_shared="%pwdvar%\shared" /GRANT:Vagrant,FULL /remark:"For Vagrant VMs."

REM Install Vagrant plugins
vagrant plugin install vagrant-disksize
vagrant plugin install vagrant-list
vagrant plugin install vagrant-rekey-ssh

REM Develop VM from Vagrantfile
vagrant up test1