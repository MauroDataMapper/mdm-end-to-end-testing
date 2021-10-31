import { Then, When, And, Given } from 'cypress-cucumber-preprocessor/steps';
import { SubscribedCataloguePage } from "../subscribed-catalogues-page";
import { AddSubscribedCatalogueForm } from "../add-subscribed-catalogue-form";

const page = new SubscribedCataloguePage();
const form = new AddSubscribedCatalogueForm();

And(/^I am on the subscribed catalogues page$/, () => {
    page.visit();
});

Given(/^I click the add button$/, () => {
    page.getAddButton().click();
});

When(/^I enter "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)" and "([^"]*)"$/, (label, description, url, apiKey, refreshPeriod) => {
    form.getLabelField().type(label);
    if (description) {
        form.getDescriptionField().type(description);
    }
    form.getUrlField().type(url);
    if (apiKey) {
        form.getApiKeyField().type(apiKey);
    }
    if (refreshPeriod) {
        form.getRefreshPeriodField().type(refreshPeriod);
    }
});

And(/^I click the add subscription button$/, () => {
    form.getAddSubscriptionButton().click();
});