# Copyright 2021 University of Oxford
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Feature: Login
    As a user of Mauro
    Login / Logout functions correctly

    Scenario: Login as administrator
        Given I go to the home page
        When I login as "admin@maurodatamapper.com" with password "password"
        Then I am logged in as "Admin User"
        Then Logout

    Scenario: Login as administrator (case insensitive 1)
        Given I go to the home page
        When I login as "ADMIN@maurodatamapper.com" with password "password"
        Then I am logged in as "Admin User"
        Then Logout

    Scenario: Login as administrator (case insensitive 2)
        Given I go to the home page
        When I login as "ADMIN@MAURODATAMAPPER.COM" with password "password"
        Then I am logged in as "Admin User"
        Then Logout

    Scenario: Login as administrator (with spaces)
        Given I go to the home page
        When I login as "  admin@maurodatamapper.com  " with password "password"
        Then I am logged in as "Admin User"
        Then Logout

    Scenario: Do not enter username and password
        Given I go to the home page
        When I open the Log in form
        And I leave all form fields empty
        And Click the Log in button
        Then I am not logged in
        And There are validation errors in the login form
