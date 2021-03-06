# Install and activate Azure module
PSInstall-Module AzureRM.NetCore                                                             
Import-Module AzureRM.Netcore
Import-Module AzureRM.Profile.Netcore
Login-AzureRmAccount 

# Prompt for credential for VM to deploy in Azure
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."

# Deploy new VM
New-AzureRmVM -Name Unique2354252vm -Credential $cred

# Clean up after testing is complete
Get-AzureRmResourceGroup | Remove-AzureRmResourceGroup -Verbose -Force
