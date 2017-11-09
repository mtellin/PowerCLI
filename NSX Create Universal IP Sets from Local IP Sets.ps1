# --------------------------------------------------
# 
# Mike Tellinghuisen
# 2017-04-10
# Loop through NSX non-Universal IP Sets and create
# Universal IP sets from them. Non-Universal IP sets
# are not removed during this script.
#
# --------------------------------------------------

$local = Get-NsxIpSet -LocalOnly
Foreach ($i in $local)
{
  New-NsxIpSet -Name ($i.name + "-Universal") -IpAddresses $i.value -Universal
}