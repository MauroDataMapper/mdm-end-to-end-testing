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

Feature: Model Tree

    As an administrator of Mauro
    I want to navigate around Mauro using the model tree to view catalogue items

    Background: Must be logged in at the correct page
        Given I am logged in as the administrator user
        And I am on the main catalogue browsing page

    Scenario: View the model tree
        Then I see the model tree
        And The catalogue item detail view is empty

    Scenario Outline: Select a catalogue item from the model tree
        When I click on "<label>" with version "<version>" in the model tree
        Then The catalogue item detail view displays "<label>" of type "<type>"

        Examples:
            | label                         | version   | type                  |
            | Complex Test DataModel        |           | dataModel             |
            | Model Version Tree DataModel  | main      | dataModel             |
            | Model Version Tree DataModel  | 5.0.0     | dataModel             |
            | Simple Test Terminology       |           | terminology           |
            | Simple Reference Data Model   |           | referenceDataModel    |
            | Simple Test CodeSet           | 1.0.0     | codeSet               |