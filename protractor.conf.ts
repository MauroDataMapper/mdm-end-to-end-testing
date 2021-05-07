//protractor.conf.js
import { browser, Config } from "protractor";
import { Reporter } from "./support/reporter";

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
    '../features/**/*.feature'
  ],

  SELENIUM_PROMISE_MANAGER: false,

  baseUrl: 'http://localhost:8082/',
  cucumberOpts: {
    //compiler: "ts:ts-node/register",
    format: "json:../reports/json/cucumber_report.json",
    require: ['./features/step_definitions/*.js'],  // require step definition files before executing features
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
