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

Feature: Mauro Home Page
    As a user of Mauro
    The home page should be loaded correctly

    Scenario: Home page is identifiably the home page
        When I go to the home page
        Then I'm on the home page

    Scenario: Home page contains default text and branding
        When I go to the home page
        Then Default home page text is present

    Scenario: Home page shows login buttons
        When I go to the home page
        Then Login Button is shown

