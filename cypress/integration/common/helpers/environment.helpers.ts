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
 * Gets a full API endpoint to Mauro.
 * @param url An optional relative URL to append.
 * @returns The full API endpoint to use.
 */
export const apiEndpoint = (url?: string) => {
  const baseUrl = Cypress.env('apiEndpoint');
  if (!url) {
    return baseUrl;
  }

  return `${baseUrl}${url}`;
}