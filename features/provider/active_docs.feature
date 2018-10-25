Feature: ActiveDocs pages
  As a provider
  I want to manage my ActiveDocs

  Background:
    Given a provider is logged in
      And the provider has 1 active doc

  Scenario: Index renders with the proper elements
    When I go to the provider active docs page
    Then I should see "ActiveDocs" within the main title
     And the table should contain the API

  Scenario: Preview renders with the proper elements
    When I go to the preview active docs page
    Then I should see "ActiveDocs" within the main title

  Scenario: Edit renders with the proper elements
    When I go to the edit active docs page
    Then I should see "ActiveDocs" within the main title
     And the service selector is in the form

  Scenario: New renders with the proper elements
    When I go to the new active docs page
    Then I should see "ActiveDocs" within the main title
     And the service selector is in the form

  Scenario: Create after failing renders with the proper elements
    When I try to create an active docs with invalid data
    Then I should see the errors in the page
     And the service selector is in the form

  Scenario: Update after failing renders with the proper elements
    When I try to update an active docs with invalid data
    Then I should see the errors in the page
     And the service selector is in the form
