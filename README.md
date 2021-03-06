# Mauro Data Mapper End-to-End Tests

End-to-end testing for the Mauro Data Mapper.

| Branch | Build Status |
| ------ | ------------ |
| main | [![Build Status](https://jenkins.cs.ox.ac.uk/buildStatus/icon?job=Mauro+Data+Mapper%2Fmdm-end-to-end-testing%2Fmain)](https://jenkins.cs.ox.ac.uk/blue/organizations/jenkins/Mauro%20Data%20Mapper%2Fmdm-end-to-end-testing/branches) |
| develop | [![Build Status](https://jenkins.cs.ox.ac.uk/buildStatus/icon?job=Mauro+Data+Mapper%2Fmdm-end-to-end-testing%2Fdevelop)](https://jenkins.cs.ox.ac.uk/blue/organizations/jenkins/Mauro%20Data%20Mapper%2Fmdm-end-to-end-testing/branches) |

## Overview

This repository contains an application for performing end-to-end testing Mauro Data Mapper. While other repositories contain unit and integration testing, this application uses a running version of Mauro and simulates a number of scenarios and tests against expected outcomes.

This project uses [Cypress.io](https://www.cypress.io/) as the test framework due to its ease of use, reliability and integration into CI pipelines. A Cypress plugin has been integrated to also use [Cucumber](https://cucumber.io/) written tests to allow anyone to be able to define the appropriate test scenarios.

## Requirements

### Mauro Instance

The tests require a full version of Mauro running.
For stability this should be achieved by using the mdm-docker instance, 
we have included a build and start script for convenience which will not only build and start Mauro but also install the required fixtures.

For simplicity the script should be run with no options,
this will build the latest develop branches and start MDM on port 8082 which is what cypress is expecting.

```shell
# Build and start MDM
$ ./build_and_start_environment.sh

# Get the usage/help
$ ./build_and_start_environment.sh -h
```

Some tests will depend on pre-existing data being available in the Mauro instance - for example particular login details, or existing data models. 
The required fixtures file can be found in the `fixtures` folder, this fixtures file is installed as part of the build and start script.

mdm-docker has been included as a git submodule to allow this single repo to be cloned and run without the need for cloning any other repositories,
the script includes the command to checkout the submodule but this can be done manually using `git submodule --init`.

### Browsers

If running via the CLI, the tests run in headless mode. If running via the Cypress test runner then they will run against any available browser discovered on your system.

See [Cypress documentation on browsers](https://docs.cypress.io/guides/guides/launching-browsers#Download-specific-Chrome-version) for further details.

## Running

After cloning the repository, you will need to run this command to ensure the correct dependencies are available.

```bash
npm install
```

To run the test specs in standard headless mode, run this command. Running tests via the CLI is most suitable for CI pipelines and reporting.

```bash
npm test
```

Alternatively, you can instead view and run tests via the [Cypress test runner](https://docs.cypress.io/guides/core-concepts/test-runner) using this command:

```bash
npm start
```

Using the test runner is most suitable when writing the tests, as all test specs will automatically reload and run again as changes are made. The visual aspect of the test runner will also help identify issues with your tests.

## Reporting

Cypress has been [configured](https://docs.cypress.io/guides/tooling/reporters) to output data files necessary for generating test reports, which is defined in the `reporter-config.json` file. The following reporters have been configured:

* `spec` - The default Mocha reporter which writes to the console/terminal.
* `mocha-junit-reporter` - To output JUnit XML files.
* `mochawesome` - To generate a HTML report.

To generate reports, such as during a CI pipeline:

```bash
# Delete existing report data folder/files
# Note: For Windows (PowerShell), run this instead:
#
# Remove-Item -Force -Recurse cypress/reports
rm -rf cypress/reports

# Run all tests and generate data files required for reports
# All test result will be written to the console by default
npm run test

# Merge report data and generate the final reports, located in:
#
# cypress/reports/junit.xml
# cypress/reports/mochawesome/index.html
npm run generate-reports
```

## Writing tests

A lot of useful information regarding writing and running tests can be found at https://docs.cypress.io/.

### Organisation

All test specs are found under the `./cypress/integration` folder. The file organisation follows the system described in [cypress-cucumber-preprocessor](https://github.com/TheBrainFamily/cypress-cucumber-preprocessor#how-to-organize-the-tests):

1. There is a `common` sub-folder to hold shared test steps, page objects and helper functions.
2. Each `*.feature` file is then paired with a sub-folder with the same name to match the test steps, as described [here](https://github.com/TheBrainFamily/cypress-cucumber-preprocessor#step-definitions). For example:

```
cypress
    integration
        pages
            home
                home.steps.ts
            home.feature
```

The `common` folder will hold:

1. Shared test steps that are used across multiple `*.feature` files.
2. Page objects that used by all tests.
3. Helper functions/modules to assist with common test functionality or setup.

### Cucumber

The [cypress-cucumber-preprocessor](https://github.com/TheBrainFamily/cypress-cucumber-preprocessor) plugin has been installed in this project, allowing test scenarios to be written in [Cucumber](https://cucumber.io/) syntax. This allows anyone to easily define the various scenarios under test, while developers can fill in the test steps defined and create the page objects to interact with the application.

The [Page Object pattern](https://webdriver.io/docs/pageobjects/) is used to abstract away the complex interactions required work with the application pages and elements. Using page objects helps:

1. Encapsulate repeated logic to interact with the page/elements.
2. Simplify the test steps and make them easier to understand and write.
3. Ensure that test steps deal with higher-level functionality (e.g. "click the login button"), while the page objects deal with the lower-level interactions (e.g. locate the button labelled "Login" and trigger the click event).

The following are advised for further reading:

* [cypress-cucumber-preprocessor README](https://github.com/TheBrainFamily/cypress-cucumber-preprocessor)
* [How to integrate Cypress and Cucumber in your development flow in just a few weeks](https://itortv.medium.com/how-to-integrate-cypress-and-cucumber-in-your-development-flow-in-just-a-few-weeks-96a46ac9165a)

## Tags

You can tag tests using Cucumber's tag expressions, as explained here: https://github.com/TheBrainFamily/cypress-cucumber-example#tagging-tests. The test runners are currently configured to support the following tags (though more may be added later):

* `@exclude` - Add this to a `Scenario` or `Scenario` outline to _not_ have it verified when running tests. Useful for defining the scenarios but filling in later.

### Logging in

One of the most common predicate steps you will need to carry out before most test scenarios can actually run is to login as a user and start in a known state in Mauro Data Mapper before the actual scenario under test can start. This is so common that Cypress actually refer to this strategy in their documentation - https://docs.cypress.io/guides/getting-started/testing-your-app#Logging-in.

This project therefore providers helper functions to allow this, under `./cypress/integration/common/helpers/security.helpers.ts`. This provides the following:

```ts
import { loginAsUser, ensureUserIsLoggedOut, isUserLoggedOut } from '../helpers/security.helpers';

// Make sure that there is no authenticated session currently. 
// If there is, log out of the current session and clear local storage state
ensureUserIsLoggedOut();

// Login directly as a known user. The list of known users can be found 
// in the `cypress.json` file under the environment variable `users`.
loginAsUser('administrator').then(user => { /* Do something next... */ });

// Assert that the current user is logged out. If false, an assertion 
// failure will be thrown.
isUserLoggedOut();
```

**Note:** these helper functions directly use the Mauro REST API to manage authentication. This is acceptable for the most part, since entering each test scenario into a suitable precondition state as soon as possible avoids tests taking too long to run and focuses just on the actual functionality under test.

There are also common test steps available under `./cypress/integration/common/steps/security.steps.ts` that will allow you to provide this as `Given` conditions:

```cucumber
Feature: Model Tree

    Background:
        Given I am logged in as the administrator user
        And I am on the main catalogue browsing page

    Scenario: View the model tree
        Then I see the model tree
        And The catalogue item detail view is empty
```

Note that these test steps and helpers should only be used for background setup of test scenarios. In the case of testing the actual login/logout process via the UI, these should _not_ be used and instead verify that the login UI workflow works manually.