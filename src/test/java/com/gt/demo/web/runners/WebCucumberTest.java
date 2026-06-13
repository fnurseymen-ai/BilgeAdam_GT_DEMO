package com.gt.demo.web.runners;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import io.cucumber.testng.FeatureWrapper;
import io.cucumber.testng.PickleWrapper;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

/**
 * Web Cucumber scenario'larını TestNG üzerinden çalıştıran runner sınıfı.
 *
 * <p>features ve glue ayarları sayesinde web feature dosyaları, step definition'lar ve hook'lar
 * birlikte çalışır.
 */
@CucumberOptions(
    features = "file:src/test/resources/features/web/",
    glue = {"com.gt.demo.web"},
    plugin = {
      "pretty",
      "html:target/cucumber/web/cucumber-report.html",
      "json:target/cucumber/web/cucumber.json"
    },
    // Targets versioned smoke web scenarios by default; training-specific tags are optional.
    tags = "@web and @smoke and not @wip")
public class WebCucumberTest extends AbstractTestNGCucumberTests {

  // TestNG her Cucumber scenario'yu ayrı bir test gibi çalıştırır.
  @Override
  @Test(dataProvider = "scenarios")
  public void runScenario(PickleWrapper pickleWrapper, FeatureWrapper featureWrapper) {
    super.runScenario(pickleWrapper, featureWrapper);
  }

  // Web scenario'ları paralel çalışabilir; WebDriverContext bu yüzden ThreadLocal kullanır.
  @Override
  @DataProvider(parallel = true)
  public Object[][] scenarios() {
    return super.scenarios();
  }
}
