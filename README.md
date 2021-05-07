# mdm-end-to-end-testing

End-to-end testing for the Mauro Data Mapper

## Build status

| Branch | Build Status |
| ------ | ------------ |
| main | [![Build Status](https://jenkins.cs.ox.ac.uk/buildStatus/icon?job=Mauro+Data+Mapper%2Fmdm-end-to-end-testing%2Fmain)](https://jenkins.cs.ox.ac.uk/blue/organizations/jenkins/Mauro%20Data%20Mapper%2Fmdm-end-to-end-testing/branches) |
| develop | [![Build Status](https://jenkins.cs.ox.ac.uk/buildStatus/icon?job=Mauro+Data+Mapper%2Fmdm-end-to-end-testing%2Fdevelop)](https://jenkins.cs.ox.ac.uk/blue/organizations/jenkins/Mauro%20Data%20Mapper%2Fmdm-end-to-end-testing/branches) |

## Overview

This repository contains an application for performing end-to-end testing Mauro Data Mapper. 
While other repositories contain unit- and integration-testing, this application uses a running version of Mauro and 
simulates a number of scenarios and tests against expected outcomes.

## Requirements

### Mauro Instance

The tests assume a fresh instance of Mauro Data Mapper is running and the UI accessible at http://localhost:8082.  
This is the default configuration for mdm-docker.  If you have an instance running on a different URL, or a different port, 
you can configure the settings with the `baseUrl` setting in the `protractor.conf.ts` file. 

Some tests will reply on pre-existing data being available in the Mauro instance - for example particular login details, or existing data models.  
Currently, the default 'blank' database created during installation is sufficient, but in due course a 'fixtures' file will be provided
to initialise the Mauro instance in the correct state.

### Chrome

The tests currently run using the Chrome instance of the Web Driver.  Changing this setting is currently untested, but 
the browser settings are available in the `protractor.conf.ts` file. 

## Running

After cloning the repository, you will need to run 
```bash
npm install
```
to ensure the correct dependencies are available.

The webdriver daemon needs to be running in the background - e.g. in a separate terminal you can run 

```bash
webdriver-manager start
```

This will run the daemon until you press `Ctrl-C` to kill the process.  

Finally, you can build the test suite with

```bash
npm build
```

and run the tests with 

```bash
npm test
```

The test suite will open a Chrome browser window, run all the tests sequentially and then close the browser window.  
The console will report the number of passes / failures, and give the location of an HTML report (typically `reports/html/cucumber_reporter.html`)

## Running in 'headless' modes

As well as running with a real Chrome browser, you can also run the tests in 'headless' mode.  This is faster than 
opening a window, and will also work where no windowing system is available - for example as part of a continuous 
integration process.  To run in headless mode you can set the environment parameter `JENKINS` to the value `true' - e.g

```bash
npm build ; JENKINS=true npm test
```

Alternatively, you can modify the defaults in the `protractor.conf.ts` file.
