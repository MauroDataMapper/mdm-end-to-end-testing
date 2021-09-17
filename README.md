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

The tests currently assume that there is a front and back-end running locally at the following URLs:

* Backend: http://localhost:8080
* Frontend: http://localhost:4200

**TODO:** update this section for further instance setup details.

Some tests will depend on pre-existing data being available in the Mauro instance - for example particular login details, or existing data models. Currently, the default 'blank' database created during installation/bootstrapping is sufficient, but in due course a 'fixtures' file will be provided to initialise the Mauro instance in the correct state.

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
npm start
```

Alternatively, you can instead view and run tests via the [Cypress test runner](https://docs.cypress.io/guides/core-concepts/test-runner) using this command:

```bash
npm run test
```

Using the test runner is most suitable when writing the tests, as all test specs will automatically reload and run again as changes are made. The visual aspect of the test runner will also help identify issues with your tests.

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