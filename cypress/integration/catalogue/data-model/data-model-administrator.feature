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

    Scenario Outline: Edit a Data Model label
        Given I click on "<original_label>" with version "<version>" in the model tree
        When I change the selected catalogue item label to "<new_label>"
        Then The selected catalogue item will be updated successfully

        Examples:
            | original_label            | version   | new_label                 |
            | Complex Test DataModel    |           | Complex Test DataModel 1  |