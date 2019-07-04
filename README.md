# nessus
Docker container for Nessus 8.

This docker is aligned to utilize Ubuntu 18.04 with the corresponding Nessus .deb file. 

The Nessus file can be downloaded from here: https://www.tenable.com/downloads/nessus
Nessus-8.5.1-ubuntu1110_amd64.deb


To build:
-place the Dockerfile and the Nessus-XXXXXX.deb file in the same directory. 
-Verify the Nessus-XXXX.deb statement in the dockerfile aligns with the version
-Run the command: docker build -t nessus .
