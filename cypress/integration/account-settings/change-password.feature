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


Feature: Change User Password
  As a user of Mauro
  I want to change my password

  Background:
    Given I am logged out
    And I go to the home page

#    Given I am an anonymous user



  Scenario Outline: Login and change password, and then try logging in with it
    When I login as "<username>" with "<password>"
#    Then I go to the home page
    Then I am logged in as "<user>"

    When I go to change my password

    Examples:
      | username | password | user |
      | admin@maurodatamapper.com | password | Admin User |

