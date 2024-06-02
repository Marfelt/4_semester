$jsonFilePath = "E:/Packer/db/ubuntu2204_config.json"

$jsonContent = Get-Content -Path $jsonFilePath | ConvertFrom-Json

$buildName      = $jsonContent.build_name
$buildUsername  = $jsonContent.build_username
$outputDir      = $jsonContent.vm_output_dir
$osType         = $jsonContent.vm_guest_os_type
$osLanguage     = $jsonContent.vm_guest_os_language
$osKeyboard     = $jsonContent.vm_guest_os_keyboard
$osTimezone     = $jsonContent.vm_guest_os_timezone
$diskSize       = $jsonContent.vm_disk_size
$cpus           = $jsonContent.vm_cpus
$memory         = $jsonContent.vm_memory
$isoUrl         = $jsonContent.vm_iso_url
$isoChecksum    = $jsonContent.vm_iso_checksum

$env:PKR_VAR_build_name             = $buildName
$env:PKR_VAR_build_username         = $buildUsername
$env:PKR_VAR_vm_output_dir          = $outputDir
$env:PKR_VAR_vm_guest_os_type       = $osType
$env:PKR_VAR_vm_guest_os_language   = $osLanguage
$env:PKR_VAR_vm_guest_os_keyboard   = $osKeyboard
$env:PKR_VAR_vm_guest_os_timezone   = $osTimezone
$env:PKR_VAR_vm_disk_size           = $diskSize
$env:PKR_VAR_vm_cpus                = $cpus
$env:PKR_VAR_vm_memory              = $memory
$env:PKR_VAR_vm_iso_url             = $isoUrl
$env:PKR_VAR_vm_iso_checksum        = $isoChecksum

$packerBuildCmd = 'packer build -var-file="E:\Packer\Builds\ubuntu2204.pkrvars.hcl" E:\Packer\Builds\ubuntu2204.pkr.hcl'

Invoke-Expression $packerBuildCmd



