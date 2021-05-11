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


import { browser, Config } from "protractor";
import { Reporter } from "./utils/reporter";

const jsonReports = process.cwd() + "/reports/json";

let headlessArgs = [];
if(process.env.JENKINS && process.env.JENKINS === "true") {
  headlessArgs = ["--headless", "--disable-gpu" ];
}

export const config: Config = {
  seleniumAddress: 'http://127.0.0.1:4444/wd/hub',
  getPageTimeout: 60000,
  allScriptsTimeout: 500000,
  framework: 'custom',
  // path relative to the current config file
  frameworkPath: require.resolve('protractor-cucumber-framework'),
  capabilities: {
    'browserName': 'chrome',

    chromeOptions: {
      args: headlessArgs
    }
  },

  // Spec patterns are relative to this directory.
  specs: [
    '../tests/**/*.feature'
  ],

  SELENIUM_PROMISE_MANAGER: false,

  baseUrl: 'http://localhost:8082/',
  cucumberOpts: {
    //compiler: "ts:ts-node/register",
    format: "json:../reports/json/cucumber_report.json",
    require: ['./tests/**/*.steps.js'],  // require step definition files before executing features
    tags: [],                      // <string[]> (expression) only execute the features or scenarios with tags matching the expression
//    strict: true,                  // <boolean> fail if there are any undefined or pending steps
//    'dry-run': false,              // <boolean> invoke formatters without executing steps
  },

 onPrepare: function () {
   browser.ignoreSynchronization = true;
   browser.manage().window().setSize(1600, 1000);
   Reporter.createDirectory(jsonReports);
  },

  onComplete: () => {
    Reporter.createHTMLReport();
  }
};
