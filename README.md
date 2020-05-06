# Docker MESH

Builds a docker image to run a configured NHS Digital MESH Client.

### Building

The MESH Client is configured at build time. The build arguments are:

| Argument | Value | Default |
|----------|-------|---------|
| MESHPWD | Password for your MESH Mailbox | None |
| MESHBOX | Identifer of the MESH Mailbox | None |
| KSPASS  | Password for the MESH Keystore | None |
| MESHENDPOINT | IP or URL for the MESH Endpoint | https://192.168.128.11 (OpenTest) |

The MESH Endpoint is added to the conifguration using a SED command so needs to be escaped. e.g   

https://192.168.128.11 should be specified as https:\\/\\/192\\.168\\.128\\.11

The mesh keystore should be copied to the build directory so it can be copied into the image. The Keystores for each environment can be found here:  

https://digital.nhs.uk/services/path-to-live-environments

Passwords for the Keystore will be provided during the environment registration process.

To build, use the command:
```
docker build --build-arg MESHPWD=[MESH PASSWORD] --build-arg MESHBOX=[MESHBOXID] --build-arg KSPASS=[KeyStorePass] -t [sometag] .
```

## Data Volume
The build creates a volume at /usr/MESH-DATA-HOME.

If you wish to access the MESH mailbox from other images you may wish to create a volume first e.g.
```
docker volume create --name meshdata
```

And then use it when running the container:
```
docker run -v meshdata:/usr/MESH-DATA-HOME [sometag]
```

## License

This project contains the java installer for the MESH client which is copyright NHS Digital. It has not been altered for this project.  

The original can be found here:  

https://digital.nhs.uk/services/message-exchange-for-social-care-and-health-mesh/mesh-guidance-hub/client-installation-guidance

## Acknowledgments

* NHS Digital
