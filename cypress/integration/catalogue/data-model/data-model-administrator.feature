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

Feature: Data Models for administrators

    As an administrator user of Mauro
    I want to view and administrate all models in Mauro

    Background: I am logged in and on the catalogue page
        Given I am logged in as the administrator user
        And I am on the main catalogue browsing page

    @teardown-reset-labels
    Scenario Outline: Edit a Data Model label
        Given I click on "<label>" with version "<version>" in the model tree
        When I change the selected catalogue item label
        Then The selected catalogue item will be updated successfully

        Examples:
            | label                     | version   |
            | Complex Test DataModel    |           |

    Scenario Outline: Cancel edit of a Data Model label
        Given I click on "<label>" with version "<version>" in the model tree
        When I start changing the label of the selected catalogue item but then cancel
        Then The selected catalogue item has not been updated

        Examples:
            | label                     | version   |
            | Complex Test DataModel    |           |

    Scenario Outline: Enter an empty label for a Data Model
        Given I click on "<label>" with version "<version>" in the model tree
        When I clear all text for the label of the selected catalogue item
        Then I am unable to save the changes made

        Examples:
            | label                     | version   |
            | Complex Test DataModel    |           |