# List all dvSwitch Port Groups that have Netflow enabled, formatted to only show name and enabled status (which should be all true)
# Used to validate after configuring vRealize Network Insight
Get-VDPortgroup | where {$_.ExtensionData.Config.defaultPortconfig.ipfixenabled.value -eq "True"} | Select Name, @{Name="NetflowEnabled";Expression={$_.Extensiondata.Config.defaultPortConfig.ipfixEnabled.Value}}

# This will return the list of NSX Security Groups that are backed by Active Directory Groups for you to review
Get-NsxSecurityGroup | Where {$_.InnerXml -like "*DirectoryGroup*"}

# Alternatively, to also remove the security groups as part of the command 
# Note: you will be prompted to confirm the group(s) it finds
Get-NsxSecurityGroup | Where {$_.InnerXml -like "*DirectoryGroup*"} | Remove-NsxSecurityGroup