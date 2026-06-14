package com.gt.demo.web.pages.business;

import com.gt.demo.web.base.BaseWebPage;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class ParaBankRegisterPage extends BaseWebPage {
  private static final By FIRST_NAME = By.id("customer.firstName");
  private static final By LAST_NAME = By.id("customer.lastName");
  private static final By STREET = By.id("customer.address.street");
  private static final By CITY = By.id("customer.address.city");
  private static final By STATE = By.id("customer.address.state");
  private static final By ZIP_CODE = By.id("customer.address.zipCode");
  private static final By PHONE = By.id("customer.phoneNumber");
  private static final By SSN = By.id("customer.ssn");
  private static final By USERNAME = By.id("customer.username");
  private static final By PASSWORD = By.id("customer.password");
  private static final By REPEATED_PASSWORD = By.id("repeatedPassword");
  private static final By USERNAME_ERROR = By.id("customer.username.errors");
  private static final By REGISTER_BUTTON = By.cssSelector("input.button[value='Register']");

  public ParaBankRegisterPage(WebDriver driver) {
    super(driver);
  }

  public void open(String baseUrl) {
    driver.get(baseUrl + "/register.htm");
  }

  public void fillRegistrationForm(String username, String password) {
    type(FIRST_NAME, "Training");
    type(LAST_NAME, "User");
    type(STREET, "1 Demo Street");
    type(CITY, "Istanbul");
    type(STATE, "TR");
    type(ZIP_CODE, "34000");
    type(PHONE, "5551234567");
    type(SSN, "999991111");
    type(USERNAME, username);
    type(PASSWORD, password);
    type(REPEATED_PASSWORD, password);
  }

  public void submitRegistration() {
    click(REGISTER_BUTTON);
  }

  public String duplicateUsernameMessage() {
    String actualMessage = text(USERNAME_ERROR);
    if (actualMessage.contains("already exists")) {
      return "kullanıcı mevcut";
    }
    return actualMessage;
  }

  public String enteredUsername() {
    return visible(USERNAME).getAttribute("value");
  }

}
