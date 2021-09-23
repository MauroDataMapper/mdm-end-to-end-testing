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

Feature: Publicly readable catalogue items

    As a Mauro administrator
    I want to mark catalogue items as publicly readable for anyone to view

    As an anonymous user
    I want to be able to read any publicly readable catalogue item without signing in

    @scenario-teardown
    Scenario Outline: Mark a catalogue item as publicly readable
        Given I am logged in as the administrator user
        And I click on "<label>" with version "<version>" in the model tree
        When I mark the selected catalogue item as "Publicly readable"
        Then The selected catalogue item is now public for anyone to read

        Examples:
            | label                         | version   |
            | Complex Test DataModel        |           |
            | Model Version Tree DataModel  | 5.0.0     |
            | Complex Test Terminology      |           |
            | Simple Test CodeSet           | 1.0.0     |
            | Development Folder            |           |


    Scenario Outline: Read a public catalogue item
        Given An administrator has marked "<label>" - version: "<version>" - as publicly readable
        And I am an anonymous user
        And I am on the main catalogue browsing page
        When I click on "<label>" with version "<version>" in the model tree
        Then I can read the selected catalogue item
        And I cannot edit the selected catalogue item

        Examples:
            | label                         | version   |
            | Complex Test DataModel        |           |
            | Model Version Tree DataModel  | 5.0.0     |
            | Complex Test Terminology      |           |
            | Simple Test CodeSet           | 1.0.0     |
            | Development Folder            |           |