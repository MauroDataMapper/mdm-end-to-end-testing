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

/**
 * Represents that a page object can be navigated to.
 */
export interface Navigatable {
  /**
   * The relative URL for this page. Should include the initial forward slash but not the domain name or hash.
   */
  relativeUrl: string
}

/**
 * Type guard to test if an object is of type `Navigatable`
 */
export function isNavigatable(value: any) : value is Navigatable {
  return (value as Navigatable) !== undefined;
}