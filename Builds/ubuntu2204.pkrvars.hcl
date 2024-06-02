build_password          = "semtest123"
build_password_encrypted = "$6$rounds=4096$jMK9d2q3F6t07/jr$YS.0KoOeq.BnGf4XGnczpV6sy5v3iUaGFrc8Dqw3qjSMqlmuTk.WX24aHGsNukVRZNYxxh9TiAcnQw6dfubLM1"


vm_boot_wait            = "10s"
vm_boot_cmd             = [
    "<wait3s>c<wait3s>",
    "linux /casper/vmlinuz autoinstall ds=nocloud;",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
