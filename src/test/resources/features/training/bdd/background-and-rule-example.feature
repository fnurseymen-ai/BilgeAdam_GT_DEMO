@training @bdd
Feature: Background and Rule educational examples

  Background:
    Given I have opened the technical demo home page
    And I have verified the page heading

  Rule: Each technical example should validate one concept clearly

    Scenario: Dropdown concept validation
      When I select a value from dropdown
      And I click on the submit button
      Then the selected dropdown value should be visible

    Scenario: Iframe concept validation
      When I type a note into iframe editor
      Then the iframe editor should show the note
