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

Feature: Viewing Terminologies

    As a user of Mauro
    I want to select a Terminology and view its information

    Background: I am logged in and on the catalogue page
        Given I am logged in as the administrator user
        And I am on the main catalogue browsing page

    Scenario Outline: Viewing the standard Terminology details
        When I click on "<label>" with version "<version>" in the model tree
        Then The catalogue item with the name "<label>" is displayed
        And I can see all the catalogue item details
        And I can see all the standard options available

        Examples:
            | label                         | version   |
            | Complex Test Terminology      |           |

    Scenario Outline: Viewing a draft Terminology
        When I click on "<label>" with version "<version>" in the model tree
        Then The catalogue item with the name "<label>" is displayed
        And The draft badge is displayed with no model version
        And I can see all the draft options available

        Examples:
            | label                         | version   |
            | Complex Test Terminology      |           |            

    @exclude
    Scenario Outline: Viewing a finalised Terminology
        When I click on "<label>" with version "<version>" in the model tree
        Then The catalogue item with the name "<label>" is displayed
        And The finalised badge is displayed with the matching model version "<version>"
        And I can see all the finalised options available

        Examples:
            | label                         | version   |                       
    