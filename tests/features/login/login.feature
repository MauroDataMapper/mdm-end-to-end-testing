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

    Scenario Outline: Login as a valid user
        Given I go to the home page
        And I open the Log in form
        When I login as "<username>" with "<password>"
        Then I am logged in as "<user>"
        Then Logout

        Examples:
            | username | password | user |
            | admin@maurodatamapper.com | password | Admin User |
            | ADMIN@maurodatamapper.com | password | Admin User |
            | ADMIN@MAURODATAMAPPER.COM | password | Admin User |    

    Scenario: Login with empty form
        Given I go to the home page
        And I open the Log in form
        When I login with no inputs in the form fields
        Then I am not logged in
        And There are validation errors in the login form

    Scenario Outline: Attempt login with invalid username
        Given I go to the home page
        And I open the Log in form
        When I login as "<username>"
        Then I am not logged in
        And I see the validation message "Invalid email address"

        Examples:
            | username |
            | test |
