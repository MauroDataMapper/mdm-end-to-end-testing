# Copyright 2020 University of Oxford and Health and Social Care Information Centre, also known as NHS Digital
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

Feature: Subscribing to a model

    As a Mauro administrator
    I want to subscribe to a model in a subscribed catalogue

    Background: I am logged in and on the catalogue page
        Given I am logged in as the administrator user
        And I am on the main catalogue browsing page
        And There is a subscription to a subscribed catalogue with a published model

    Scenario: I subscribe to a model
        Given I expand the external catalogues
        And I expand an external catalogue with a model
        And I click on a model in the external catalogue
        Then The external model is displayed
        When I click the Subscribe button
        And I select the "Development Folder" and click Subscribe
        Then The subscription is successful
        When I click on the subscribed model in the model tree
        Then The model is displayed

    Scenario: I unsubscribe from a model
        Given I expand the external catalogues
        And I click on an external catalogue with a model
        And I click on a model in the external catalogue
        Then The model is displayed
        When I click the Unsubscribe button
        And I click the Yes, unsubscribe button
        Then The unsubscription is successful
