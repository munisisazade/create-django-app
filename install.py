# Author Munis Isazade
import subprocess # import subprecess for Run to Linux bash script
import sys

if len(sys.argv) > 1:
    if sys.argv[1] == "update":
        subprocess.call(['chmod +x start.sh && ./start.sh update'], shell=True)  # update module
else:
    print("Started to install Command ...") #  Print start
    subprocess.call(['chmod +x start.sh && ./start.sh'],shell=True) # call sh shell script for excecute script

