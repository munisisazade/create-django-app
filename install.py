# Author Munis Isazade
import subprocess # import subprecess for Run to Linux bash script


print("Started to install Command ...") #  Print start
subprocess.call(['chmod +x start.sh && ./start.sh'],shell=True) # call sh shell script for excecute script

