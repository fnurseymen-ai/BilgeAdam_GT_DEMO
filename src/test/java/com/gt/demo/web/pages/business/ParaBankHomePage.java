package com.gt.demo.web.pages.business;

import com.gt.demo.web.base.BaseWebPage;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class ParaBankHomePage extends BaseWebPage {
  private static final By USERNAME = By.name("username");
  private static final By PASSWORD = By.name("password");
  private static final By LOGIN_BUTTON = By.cssSelector("input.button[value='Log In']");
  private static final By REGISTER_LINK = By.cssSelector("a[href='register.htm']");
  private static final By LOGIN_ERROR = By.cssSelector("#leftPanel .error, .error");
  private static final By LOGOUT_LINK = By.cssSelector("a[href='logout.htm']");

  public ParaBankHomePage(WebDriver driver) {
    super(driver);
  }

  public void open(String baseUrl) {
    driver.get(baseUrl + "/index.htm");
  }

  public void login(String username, String password) {
    type(USERNAME, username);
    type(PASSWORD, password);
    click(LOGIN_BUTTON);
  }

  public void goToRegister() {
    click(REGISTER_LINK);
  }

  public String loginError() {
    return text(LOGIN_ERROR);
  }

  public String dashboardTitle() {
    return driver.getTitle();
  }

  public boolean isLoggedIn() {
    return !driver.findElements(LOGOUT_LINK).isEmpty();
  }
}
