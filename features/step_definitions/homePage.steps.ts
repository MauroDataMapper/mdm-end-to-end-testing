import { Before, Given, Then, When } from '@cucumber/cucumber'
import {browser, $, element, by, protractor} from "protractor";

import * as chai from 'chai';
import * as chaiAsPromised from 'chai-as-promised';
import { expect } from 'chai'
import {MenuBarPage} from "../../pages/menuBarPage";
import {LoginForm} from "../../forms/loginForm";
chai.use(chaiAsPromised);

const menuBarPage: MenuBarPage = new MenuBarPage();
const loginForm: LoginForm = new LoginForm();

Given(/^I go to "([^"]*)"$/, async function (site) {
    await browser.get(site);
});

Given('I go to the home page', async function() {
    await browser.get(browser.baseUrl + '/#/home');
    //await browser.sleep(2000);
})

Then('I\'m on the home page', async function() {
    expect(await menuBarPage.getActiveMenuLink().getText()).to.equal('Home');
})

Then('Default home page text is present', async  function() {
    expect(await  menuBarPage.getMainTextHeader().getText()).to.contain('Use the Mauro Data Mapper platform')
    expect(await  menuBarPage.getMainTextFirstParagraph().getText()).to.contain('Automatically import your existing schemas;')
})

Then('Login Button is shown', async  function() {
    expect(await menuBarPage.getLoginButton().isPresent())
})

Given(/^I login as "([^"]*)" with password "([^"]*)"$/, async function (username, password) {
    await menuBarPage.getLoginButton().click()
    await loginForm.getEmailField().sendKeys(username);
    await loginForm.getPasswordField().sendKeys(password);
    await loginForm.getLoginButton().click();
    await browser.wait(function() {
        return $('nav#mdm--navbar-desktop div.mdm--navbar-user div.profile-img').isPresent();
    });

});

Then(/^I'm logged in as "([^"]*)"$/, async function (username) {
    expect(await menuBarPage.getUserNameField().getText()).to.equal(username);
});

Then('Logout', async function() {
    await menuBarPage.getUserNameField().click();
    await menuBarPage.userMenuLogout();
    expect(await menuBarPage.getLoginButton()).not.null;
});



