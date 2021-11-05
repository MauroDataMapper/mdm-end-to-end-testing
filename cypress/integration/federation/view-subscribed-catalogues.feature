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

Feature: Viewing subscribed catalogues

    As a Mauro administrator
    I want to view the subscribed external catalogues

    As a Mauro user
    I want to view the subscribed external catalogues

    Scenario: I view a subscribed catalogue with a model as an administrator
        Given I am logged in as the administrator user
        And There is a subscription to a subscribed catalogue with a published model
        And I am on the main catalogue browsing page
        When I expand External catalogues
        Then I see the external catalogues
        When I click on an external catalogue with a model
        Then The external catalogue is displayed
        When I expand the external catalogue
        Then I see a model in the external catalogue
        Then The subscription is deleted

    Scenario: I view a subscribed catalogue without a model as an administrator
        Given I am logged in as the administrator user
        And There is a subscription to a subscribed catalogue without a published model
        And I am on the main catalogue browsing page
        When I expand External catalogues
        Then I see the external catalogues
        When I click on an external catalogue without a model
        Then The external catalogue is displayed
        When I expand the external catalogue
        Then I see no model in the external catalogue
        Then The subscription is deleted

    Scenario: I view a subscribed catalogue with a model as an editor
        Given I am logged in as the editor user
        And There is a subscription to a subscribed catalogue with a published model
        And I am on the main catalogue browsing page
        When I expand External catalogues
        Then I see the external catalogues
        When I click on an external catalogue with a model
        Then The external catalogue is displayed
        When I expand the external catalogue
        Then I see a model in the external catalogue
        Then The subscription is deleted

    Scenario: I view a subscribed catalogue without a model as an editor
        Given I am logged in as the editor user
        And There is a subscription to a subscribed catalogue without a published model
        And I am on the main catalogue browsing page
        When I expand External catalogues
        Then I see the external catalogues
        When I click on an external catalogue without a model
        Then The external catalogue is displayed
        When I expand the external catalogue
        Then I see no model in the external catalogue
        Then The subscription is deleted
