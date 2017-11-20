# List all dvSwitch Port Groups that have Netflow enabled, formatted to only show name and enabled status (which should be all true)
# Used to validate after configuring vRealize Network Insight
Get-VDPortgroup | where {$_.ExtensionData.Config.defaultPortconfig.ipfixenabled.value -eq "True"} | Select Name, @{Name="NetflowEnabled";Expression={$_.Extensiondata.Config.defaultPortConfig.ipfixEnabled.Value}}

# This will return the list of NSX Security Groups that are backed by Active Directory Groups for you to review
Get-NsxSecurityGroup | Where {$_.InnerXml -like "*DirectoryGroup*"}

# Alternatively, to also remove the security groups as part of the command 
# Note: you will be prompted to confirm the group(s) it finds
Get-NsxSecurityGroup | Where {$_.InnerXml -like "*DirectoryGroup*"} | Remove-NsxSecurityGroup

# Find NSX service that contains specific port - in this case 8281 for vRealize Orchestrator
Get-NsxService | where {$_.element.value -eq "8281" -and $_.IsUniversal -eq "false"}

# Create a non-universal firewall rule from a specific source and destination VM as well as service
Get-NsxFirewallSection "vRA" | New-NsxFirewallRule -Name "Appliance to vRO" -Source (get-vm VRL-AUT1) -destination (get-vm VRL-ORC1) -service (Get-NsxService | where {$_.InnerXml -like "*<value>8281*" -and $_.IsUniversal -eq "false"}) -action Allow -EnableLogging

# Get all applicable firewall rules for a VM
# Note: Need to fix, command works but returns too much info on the firewall name column
Get-NsxCliDfwRule -VirtualMachine (Get-VM VRL-AUT1) | Select RuleID, @{Name="RuleName";Expression={Get-NsxFirewallRule -RuleId $_.ruleid | Select Name}} | Sort-Object RuleId -Descending
