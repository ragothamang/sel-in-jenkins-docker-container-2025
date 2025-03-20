package com.mycompany.tests;

import com.aventstack.extentreports.Status;
import com.mycompany.base.BaseTest;
import com.mycompany.pages.GoogleHomePage;

import org.testng.Assert;
import org.testng.annotations.Test;

public class GoogleSearchTest extends BaseTest {
    
    @Test
    public void searchSelenium() {
        // Create a new test in the Extent Report
        test = extent.createTest("Google Search Selenium Test", "Open Google and search for 'selenium'");

        // Instantiate the page object
        GoogleHomePage googlePage = new GoogleHomePage(driver);
        
        // Step 1: Navigate to Google
        test.log(Status.INFO, "Navigating to Google");
        googlePage.goTo();

        // Step 2: Perform a search for "selenium"
        test.log(Status.INFO, "Searching for 'selenium'");
        googlePage.search("selenium");

        // Optional: Add an assertion to verify that the page title contains "selenium"
        String pageTitle = driver.getTitle();
        if(pageTitle.toLowerCase().contains("google")) {
            test.log(Status.PASS, "Page title contains 'google'");
        } else {
            test.log(Status.FAIL, "Page title does not contain 'google'");
        }
        Assert.assertTrue(pageTitle.toLowerCase().contains("google"), "Page title should contain 'google'");
    }
}
