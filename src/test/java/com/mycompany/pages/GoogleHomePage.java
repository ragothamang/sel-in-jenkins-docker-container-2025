package com.mycompany.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class GoogleHomePage {
    private WebDriver driver;

    // Locator for the search input box
    private By searchBox = By.name("q");

    // Constructor to initialize the driver
    public GoogleHomePage(WebDriver driver) {
        this.driver = driver;
    }

    // Method to navigate to Google
    public void goTo() {
        driver.get("https://www.google.com");
    }

    // Method to perform a search
    public void search(String text) {
        WebElement searchInput = driver.findElement(searchBox);
        searchInput.sendKeys(text);
        searchInput.submit();
    }
}
