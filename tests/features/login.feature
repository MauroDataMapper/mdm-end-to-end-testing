#features/test.feature
Feature: Login
    As a user of Mauro
    Login / Logout functions correctly

    Scenario: Login as administrator
        Given I go to the home page
        And I login as "admin@maurodatamapper.com" with password "password"
        Then I'm logged in as "Admin User"
        Then Logout

    Scenario: Login as administrator (case insensitive 1)
        Given I go to the home page
        And I login as "ADMIN@maurodatamapper.com" with password "password"
        Then I'm logged in as "Admin User"
        Then Logout

    Scenario: Login as administrator (case insensitive 2)
        Given I go to the home page
        And I login as "ADMIN@MAURODATAMAPPER.COM" with password "password"
        Then I'm logged in as "Admin User"
        Then Logout

    Scenario: Login as administrator (with spaces)
        Given I go to the home page
        And I login as "  admin@maurodatamapper.com  " with password "password"
        Then I'm logged in as "Admin User"
        Then Logout
