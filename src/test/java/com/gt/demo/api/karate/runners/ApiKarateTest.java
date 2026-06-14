package com.gt.demo.api.karate.runners;

import com.intuit.karate.junit5.Karate;

public class ApiKarateTest {

  @Karate.Test
  Karate runApiFeatures() {
    return Karate.run("file:src/test/resources/features/api").tags("~@wip").outputCucumberJson(true);
  }
}
