package com.gt.demo.web.steps;

import com.gt.demo.common.config.FrameworkConfig;
import com.gt.demo.web.base.WebDriverContext;
import com.gt.demo.web.pages.business.ParaBankHomePage;
import com.gt.demo.web.pages.business.ParaBankRegisterPage;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.Assert;

public class ParaBankBusinessSteps {
  private static final Logger LOG = LoggerFactory.getLogger(ParaBankBusinessSteps.class);
  private final ParaBankHomePage homePage = new ParaBankHomePage(WebDriverContext.get());
  private final ParaBankRegisterPage registerPage = new ParaBankRegisterPage(WebDriverContext.get());
  private String generatedUsername;
  private String generatedPassword;
  private static final String DEFAULT_REGISTER_PASSWORD = "Training123!";

  @Given("Parabank ana sayfasini actim")
  @Given("I open ParaBank home page")
  public void openParaBankHomePage() {
    homePage.open(FrameworkConfig.getRequired("web.business.baseUrl"));
  }

  @When("I login with valid business credentials")
  public void loginWithValidBusinessCredentials(String username, String password) {
    homePage.login(username, password);
  }

  @Then("I should see a business login error")
  public void shouldSeeBusinessLoginError() {
    String actualError = homePage.loginError();
    Assert.assertTrue(
        actualError.contains("could not be verified"),
        "Expected ParaBank invalid login message to contain 'could not be verified' but was: "
            + actualError);
  }
  @Then("I should be redirected to the business homepage dashboard")
  public void shouldBeRedirectedToBusinessHomepageDashboard() {
    String actualTitle = homePage.dashboardTitle();
    Assert.assertEquals(
        actualTitle,
        "ParaBank | Welcome",
        "Expected ParaBank homepage title not found.");
  }

  @Given("I open ParaBank registration page")
  @Given("Parabank kayıt sayfasını açtım")
  public void openParaBankRegistrationPage() {
    registerPage.open(FrameworkConfig.getRequired("web.business.baseUrl"));
  }

  @When("I complete business registration with unique user")
  public void completeBusinessRegistrationWithUniqueUser() {
    generatedUsername = "trainer_" + System.currentTimeMillis();
    generatedPassword = DEFAULT_REGISTER_PASSWORD;
    LOG.info("Generated ParaBank username: {}", generatedUsername);
    registerPage.fillRegistrationForm(generatedUsername, generatedPassword);
  }

  @When("I register with an existing username")
  @When("Ayni kullanıcı adı ile kayıt olmaya çalışıyorum")
  public void registerWithExistingUsername() {
    generatedUsername = "trainer_dup_" + System.currentTimeMillis();
    generatedPassword = DEFAULT_REGISTER_PASSWORD;
    registerPage.fillRegistrationForm(generatedUsername, generatedPassword);
    registerPage.submitRegistration();
    registerPage.open(FrameworkConfig.getRequired("web.business.baseUrl"));
    registerPage.fillRegistrationForm(generatedUsername, generatedPassword);
    registerPage.submitRegistration();
  }

  @Then("I should see registration form filled with my generated username")
  public void shouldSeeRegistrationFormFilledWithMyGeneratedUsername() {
    Assert.assertEquals(
        registerPage.enteredUsername(),
        generatedUsername,
        "Expected registration form to keep the entered username.");
  }

  @Then("I should see a duplicate username registration error message {string}")
  public void shouldSeeADuplicateUsernameRegistrationErrorMessage(String expectedMessage) {
    Assert.assertEquals(
        registerPage.duplicateUsernameMessage(),
        expectedMessage,
        "Expected ParaBank duplicate registration message did not match.");
  }

  @Then("kullanıcı mevcut hata mesajını görmeliyim")
  public void shouldSeeDuplicateUsernameRegistrationErrorInTurkish() {
    shouldSeeADuplicateUsernameRegistrationErrorMessage("kullanıcı mevcut");
  }
}
