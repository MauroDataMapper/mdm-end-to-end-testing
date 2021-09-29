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

Feature: Default profile information

    As a general user
    I want to view the common profile information for any catalogue item

    As a Mauro administrator
    I want to be able to create and modify the common profile information for any catalogue item

    Scenario Outline: Anonymous user can read default profile details
        Given I am an anonymous user
        And I am on the main catalogue browsing page
        When I click on "<label>" with version "<version>" in the model tree
        Then I can see the selected catalogue item's default profile
        And I cannot modify the selected catalogue item's default profile

        Examples:
            | label                     | version   |
            | Complex Test DataModel    |           |
            | Development Folder        |           |