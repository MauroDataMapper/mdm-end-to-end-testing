/**
 * Copyright 2021 University of Oxford
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { browser } from 'protractor';
import { isNavigatable, Navigatable } from '../objects/mdm-interfaces';

/**
 * Navigate to a page/URL in the browser.
 * @param location Either a `Navigatable` object or a string representing the relative URL.
 */
export async function navigateTo(location: Navigatable | string) {
  const relativeUrl = isNavigatable(location) ? location.relativeUrl : location;
  await browser.get(browser.baseUrl + '/#' + relativeUrl);
}