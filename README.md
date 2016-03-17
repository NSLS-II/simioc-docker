### Overview

This image provides an [EPICS](http://www.aps.anl.gov/epics/) IOC for interaction. This IOC provides PVs (process variables) to interact with 6 independent motors, an [areadetector](http://cars9.uchicago.edu/software/epics/areaDetector.html) camera producing 1024x1024 images, and 6 point-detectors. These point-sensors yield scalar values whose amplitude depends on the position of an associated simulated motor, with peak values produced at the motor positions indicated in the table below.

The pv names and descriptions are here:

| PV Name | Description |
| :-----: | :-------:   |
|sim:mtr1 | Motor Record 1 |
|sim:mtr2 | Motor Record 2 |
|sim:mtr3 | Motor Record 3 |
|sim:mtr4 | Motor Record 4 |
|sim:mtr5 | Motor Record 5 |
|sim:mtr6 | Motor Record 6 |
| ------- | -------        |
|sim:dev1:curr | scaler sensor 1; linked to 'sim:mtr1'; peak value at 1.5 |
|sim:dev2:curr | scaler sensor 2; linked to 'sim:mtr2'; peak value at 0.5 |
|sim:dev3:curr | scaler sensor 3; linked to 'sim:mtr3'; peak value at -0.5 |
|sim:dev4:curr | scaler sensor 4; linked to 'sim:mtr4'; peak value at -1.5 |
|sim:dev5:curr | scaler sensor 5; linked to 'sim:mtr5'; peak value at -2.5 |
|sim:dev6:curr | scaler sensor 6; linked to 'sim:mtr6'; peak value at -1.0 |
| ------- | -------        |
|sim:det: | areaDetector pv prefix; available plugins include 'image1:', 'cam1:', 'Stats1-5', etc|
| ------- | -------        |
| sim:fake:mtr-sp | setpoint of motor-like device; writes do not cause motion |
| sim:fake:mtr-i  | position readback of motor-like device |
| sim:fake:mtr:go-cmd | if a new setpoint was entered, writing a '1' to this pv causes motion |
| sim:fake:mtr:stop-cmd | writing '1' to this pv will terminate in-progress motion |
| sim:fake:mtr:moving-sts | reports state, "Moving" (0) or "Done" (1) |

## Docker Image

A Docker image is available:
```shell
docker pull dchabot/simioc
docker run -d dchabot/simioc
```

### Host Environment

To be enable host-access to the process variables published by the IOC, a couple of EPICS environment variables are required to be set:
```shell
export EPICS_CA_AUTO_ADDR_LIST=NO
export EPICS_CA_ADDR_LIST=172.17.255.255  # use `ifconfig`, or similar, to examine the host-container network configuration
```

Access to the IOC shell (iocsh) is available via `procServ`, on port 2048 of the docker image:
```shell
docker ps -a  # locate the name or ID of the simioc image
docker exec -it <image ID> bash  # launch a bash shell attached to the running image

root@<image ID> telnet localhost 2048  # enter the IOC shell
```
