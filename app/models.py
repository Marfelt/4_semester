from pydantic import BaseModel


class VariableUpdate(BaseModel):
    build_name:             str = ""
    build_username:         str = ""
    vm_output_dir:          str = ""
    vm_guest_os_type:       str = ""
    vm_guest_os_language:   str = ""
    vm_guest_os_keyboard:   str = ""
    vm_guest_os_timezone:   str = ""
    vm_disk_size:           str = ""
    vm_cpus:                str = ""
    vm_memory:              str = ""
    vm_iso_url:             str = ""
    vm_iso_checksum:        str = ""