#features/test.feature
Feature: Mauro Home Page
    As a user of Mauro
    The home page should be loaded correctly

    Scenario: Home page is identifiably the home page
        Given I go to the home page
        Then I'm on the home page

    Scenario: Home page contains default text and branding
        Given I go to the home page
        Then Default home page text is present

    Scenario: Home page shows login buttons
        Given I go to the home page
        Then Login Button is shown

