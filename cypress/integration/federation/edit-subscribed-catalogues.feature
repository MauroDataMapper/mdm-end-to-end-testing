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
#
# SPDX-License-Identifier: Apache-2.0

Feature: Editing subscribed catalogues

    As a Mauro administrator
    I want to configure connections to subscribed catalogues

    Background: I am logged in and on the subscribed catalogues page
        Given I am logged in as the administrator user
        And I am on the subscribed catalogues page

    Scenario Outline: Connect to a valid subscribed catalogue
        Given I click the add button
        When I enter "<label>", "<description>", "<url>", "<api_key>" and "<refresh_period>"
        And I click the add subscription button
        Then The subscribed catalogue is added successfully
        Then The subscription is deleted using the delete button

        Examples:
            | label                          | description | url                                                      | api_key                              | refresh_period |
            | Continuous Deployment (public) | CD instance | https://modelcatalogue.cs.ox.ac.uk/continuous-deployment |                                      |                |
            | Continuous Deployment (admin)  | CD instance | https://modelcatalogue.cs.ox.ac.uk/continuous-deployment | e2ea4cbb-6aaf-4807-a505-514c8fbed54b |                |

    Scenario Outline: Connect to an invalid subscribed catalogue
        Given I click the add button
        When I enter "<label>", "<description>", "<url>", "<api_key>" and "<refresh_period>"
        And I click the add subscription button
        Then There is an error adding the subscription

        Examples:
            | label                | description | url                      | api_key | refresh_period |
            | Invalid subscription |             | http://invalid.localhost |         |                |

    Scenario: Test connection to a subscribed catalogue with an API key
        Given There is a subscription to a subscribed catalogue with an API key
        When I click the test subscription button
        Then The test is successful
        Then The subscription is deleted

    Scenario: Test connection to a subscribed catalogue without an API key
        Given There is a subscription to a subscribed catalogue without an API key
        When I click the test subscription button
        Then The test is successful
        Then The subscription is deleted