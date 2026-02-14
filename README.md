# 4. Semester Afsluttende Projekt

A FastAPI application integrated with Packer for automating the templating and configuration of Ubuntu 22.04 virtual machines.

## Project Overview

This project combines a Python FastAPI backend with Packer infrastructure-as-code (IaC) to provide a unified interface for:
- Managing Packer build configurations
- Templating virtual machines with custom specifications
- Storing and retrieving VM build variables
- Automating VM creation with consistent, reproducible builds

## Project Structure

```
.
├── app/                          # Python FastAPI application
│   ├── main.py                   # Application entry point
│   ├── app.py                    # FastAPI application definition
│   ├── models.py                 # Pydantic data models
│   └── __pycache__/              # Python cache directory
├── Builds/                       # Packer build configurations
│   ├── ubuntu2204.pkr.hcl        # Packer configuration for Ubuntu 22.04
│   ├── ubuntu2204.pkrvars.hcl    # Packer variables file
│   └── http/                     # HTTP boot files
│       ├── meta-data             # Cloud-init metadata
│       └── user-data             # Cloud-init user data script
├── db/                           # Configuration and database files
│   └── ubuntu2204_config.json    # VM build variables storage
├── PackerBuild.ps1              # PowerShell script to execute Packer builds
└── requirements.txt             # Python dependencies
```

## Features

- **REST API Endpoints**: Manage build variables through HTTP requests
- **Packer Integration**: Automated VM templating with configurable specifications
- **Configuration Management**: Store and update build variables dynamically
- **Cloud-Init Support**: Automatic VM initialization with custom settings

## Technology Stack

- **Backend**: FastAPI, Uvicorn
- **Validation**: Pydantic
- **Infrastructure**: Packer, VirtualBox
- **Database**: MongoDB (optional, pymongo included)
- **Configuration**: JSON-based config storage

## Installation

### Prerequisites

- Python 3.8+
- Packer
- VirtualBox
- PowerShell (for running PackerBuild.ps1)

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd 4_semester-master
   ```

2. **Create a virtual environment** (recommended)
   ```bash
   python -m venv venv
   source venv/Scripts/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

## Running the Application

### Start the FastAPI Server

```bash
python app/main.py
```

The API will be available at `http://127.0.0.1:8000`

### Access API Documentation

- **Swagger UI**: http://127.0.0.1:8000/docs
- **ReDoc**: http://127.0.0.1:8000/redoc

### Execute Packer Builds

On Windows with PowerShell:

```powershell
.\PackerBuild.ps1
```

This script reads the configuration from `db/ubuntu2204_config.json` and executes the Packer build with the specified variables.

## API Endpoints

### Update Build Variables

**Endpoint**: `PUT /build_variables/`

Updates individual variables used in the Packer build configuration.

**Request Body**:
```json
{
  "build_name": "ubuntu-vm-01",
  "build_username": "ubuntu",
  "vm_output_dir": "/output",
  "vm_guest_os_type": "Ubuntu_64",
  "vm_guest_os_language": "en_US",
  "vm_guest_os_keyboard": "us",
  "vm_guest_os_timezone": "UTC",
  "vm_disk_size": "51200",
  "vm_cpus": "4",
  "vm_memory": "4096",
  "vm_iso_url": "http://releases.ubuntu.com/22.04/...",
  "vm_iso_checksum": "sha256:..."
}
```

**Response**: Returns the updated configuration as JSON

## Configuration

Build variables are stored in `db/ubuntu2204_config.json`:

```json
{
  "build_name": "ubuntu-vm",
  "build_username": "ubuntu",
  "vm_output_dir": "E:\\output",
  "vm_guest_os_type": "Ubuntu_64",
  "vm_guest_os_language": "en_US",
  "vm_guest_os_keyboard": "us",
  "vm_guest_os_timezone": "UTC",
  "vm_disk_size": 51200,
  "vm_cpus": 4,
  "vm_memory": 4096,
  "vm_iso_url": "...",
  "vm_iso_checksum": "..."
}
```

## Data Models

### VariableUpdate

Pydantic model for validating build variable updates:

- `build_name`: Name of the VM being built
- `build_username`: Username for VM login
- `vm_output_dir`: Directory for output files
- `vm_guest_os_type`: Type of operating system
- `vm_guest_os_language`: System language
- `vm_guest_os_keyboard`: Keyboard layout
- `vm_guest_os_timezone`: System timezone
- `vm_disk_size`: Disk size in MB
- `vm_cpus`: Number of CPU cores
- `vm_memory`: Memory size in MB
- `vm_iso_url`: ISO file URL
- `vm_iso_checksum`: ISO file checksum

## Dependencies

Key Python packages:
- `fastapi` - Web framework
- `uvicorn` - ASGI server
- `pydantic` - Data validation
- `pymongo` - MongoDB driver (optional)
- `python-dotenv` - Environment configuration
- `typer` - CLI support

See `requirements.txt` for complete list.

## Development Notes

- The application uses Windows Proactor Event Loop policy for compatibility with Windows systems
- Configuration paths are currently hardcoded (e.g., `E:/Packer/db/`) and may need adjustment for different environments
- The API gracefully handles shutdown signals (Ctrl+C)
- Startup and shutdown events are logged for monitoring

## Error Handling

The API implements error handling with HTTP exceptions for invalid requests. Check the FastAPI documentation endpoint at `/docs` for detailed error responses.

## License

[Add your license information here]

## Author

4. Semester Capstone Project

## Support

For issues or questions, please refer to the project documentation or contact the development team.
