import subprocess
import json
import sys
import signal
from fastapi.responses import JSONResponse
from fastapi import FastAPI, HTTPException
from models import *

app = FastAPI(
    title="Afsluttende Projekt, 4. Semester",
    description="FastAPI applikation med Packer integration til templating af virtuelle maskiner"
)

def receive_signal(signalNumber, frame):
    print('Received:', signalNumber)
    #sys.exit(0)

# Set the signal handler for SIGINT globally
signal.signal(signal.SIGINT, receive_signal)

@app.on_event("startup")
async def startup_event():
    print("Startup event triggered")

@app.on_event("shutdown")
async def shutdown_event():
    print("Shutdown event triggered")



@app.put(
        "/build_variables/",
         tags           = ["Configuration"],
         summary        = "Change build variables",
         description    = "Change individual variables used in the packer build"
         )
async def update_variables(variables: VariableUpdate):
    file_path = "E:/Packer/db/"

    with open(f"{file_path}ubuntu2204_config.json", "r") as json_file:
        existing_data = json.load(json_file)
    
    for key, value in variables.dict().items():
        if value != "":
            existing_data[key] = value
    
    with open(f"{file_path}ubuntu2204_config.json", "w") as json_file:
        json.dump(existing_data, json_file, indent=4)
    
    return existing_data

@app.post(
        "/build",
         tags           = ["Build"],
         summary        = "Start build",
         description    = "Start the packer build"
         )
async def start_build():
    ps_cmd = r"E:\Packer\PackerBuild.ps1"
    result = subprocess.run(["powershell", "-Command", ps_cmd],
                            check=True,
                            stdout=sys.stdout,
                            text=True
                            )

    return JSONResponse(
        status_code = 202,
        content = "build started"
    )
