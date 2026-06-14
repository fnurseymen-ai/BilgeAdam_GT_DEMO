package com.gt.demo.api.karate.runners;

import com.intuit.karate.junit5.Karate;

public class ApiKarateTest {

  @Karate.Test
  Karate runApiFeatures() {
    return Karate.run("classpath:features/api").tags("@tekrun").outputCucumberJson(true);
  }
}
