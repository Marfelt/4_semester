variable "build_username" {
  type        = string
  description = "Username to login to the VM"
}

variable "build_password" {
  type        = string
  description = "Password used to login to the VM"
}

variable "build_password_encrypted" {
  type        = string
  description = "Encrypted version of the password, used specifically on Linux"
}

variable "build_name" {
  type        = string
  description = "The name for the VM being built"
}

variable "vm_guest_os_language" {
  type        = string
  description = "The language to be set in the VM"
}

variable "vm_guest_os_keyboard" {
  type        = string
  description = "The keyboard input for the VM"
  default     = "us"
}

variable "vm_guest_os_timezone" {
  type        = string
  description = "The designated timezone for the VM"
}

variable "vm_disk_size" {
  type        = number
  description = "The size of the disk for the VM in MB"
}

variable "vm_cpus" {
  type        = number
  description = "The number of CPUs in the VM"
}

variable "vm_memory" {
  type        = number
  description = "the size for the memory in MB"
}

variable "vm_guest_os_type" {
  type        = string
  description = "The type of operating system on the VM"
}

variable "vm_iso_url" {
  type        = string
  description = "The URL for the iso-file used in the build"
}

variable "vm_iso_checksum" {
  type        = string
  description = "Checksum for the iso url"
}

variable "vm_boot_wait" {
  type        = string
  description = "The delay before the boot command is written"
}

variable "vm_boot_cmd" {
  type        = list(string)
  description = "The boot command written in the VM before the boot process"
}

variable "vm_output_dir" {
  type        = string
  description = "The directory where the finished build file will be put"
}

locals {
  data_src = {
    "/meta-data" = file("E:/Packer/Builds/http/meta-data")
    "/user-data" = templatefile("E:/Packer/Builds/http/user-data", {
      build_username            = var.build_username
      build_password_encrypted  = var.build_password_encrypted
      vm_guest_os_language      = var.vm_guest_os_language
      vm_guest_os_keyboard      = var.vm_guest_os_keyboard
      vm_guest_os_timezone      = var.vm_guest_os_timezone
      })
    }
}


source "virtualbox-iso" "ubuntu2204" {
  guest_os_type         = var.vm_guest_os_type
  iso_url               = var.vm_iso_url
  iso_checksum          = var.vm_iso_checksum
  keep_registered       = true
  vm_name               = var.build_name
  disk_size             = var.vm_disk_size
  guest_additions_path  = "VBoxGuestAdditions.iso"
  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--memory", var.vm_memory],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
    ["modifyvm", "{{.Name}}", "--cpus", var.vm_cpus]
  ]

  output_directory      = var.vm_output_dir
  output_filename       = var.build_name

  communicator          = "ssh"
  ssh_username          = var.build_username
  ssh_password          = var.build_password
  ssh_timeout           = "120m"
  
  cd_content            = local.data_src
  cd_label              = "CIDATA"

  boot_wait             = var.vm_boot_wait
  boot_command          = var.vm_boot_cmd

  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
}
 
build {
  sources = ["sources.virtualbox-iso.ubuntu2204"]

  provisioner "shell" {
    inline = ["sudo apt update -y && sudo apt upgrade -y"]
  }
}