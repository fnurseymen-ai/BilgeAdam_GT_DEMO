package com.gt.demo.web.steps;

import com.gt.demo.common.config.FrameworkConfig;
import com.gt.demo.web.base.WebDriverContext;
import com.gt.demo.web.pages.business.ParaBankHomePage;
import com.gt.demo.web.pages.business.ParaBankRegisterPage;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.Assert;

public class ParaBankBusinessSteps {
  private final ParaBankHomePage homePage = new ParaBankHomePage(WebDriverContext.get());
  private final ParaBankRegisterPage registerPage = new ParaBankRegisterPage(WebDriverContext.get());
  private String generatedUsername;
  private final String generatedPassword = "Training123!";

  @Given("Parabank ana sayfasini actim")
  @Given("I open ParaBank home page")
  public void openParaBankHomePage() {
    homePage.open(FrameworkConfig.getRequired("web.business.baseUrl"));
  }

  @When("I login with invalid business credentials")
  public void loginWithInvalidBusinessCredentials() {
    homePage.login("invalid-user", "invalid-pass");
  }

  @Then("I should see a business login error")
  public void shouldSeeBusinessLoginError() {
    String actualError = homePage.loginError();
    Assert.assertTrue(
        actualError.contains("could not be verified"),
        "Expected ParaBank invalid login message to contain 'could not be verified' but was: "
            + actualError);
  }

  @Given("I open ParaBank registration page")
  public void openParaBankRegistrationPage() {
    registerPage.open(FrameworkConfig.getRequired("web.business.baseUrl"));
  }

  @When("I complete business registration with unique user")
  public void completeBusinessRegistrationWithUniqueUser() {
    generatedUsername = "trainer_" + System.currentTimeMillis();
    registerPage.fillRegistrationForm(generatedUsername, generatedPassword);
  }

  @Then("I should see registration form filled with my generated username")
  public void shouldSeeRegistrationFormFilledWithMyGeneratedUsername() {
    Assert.assertEquals(
        registerPage.enteredUsername(),
        generatedUsername,
        "Expected registration form to keep the entered username.");
  }
}
