# frozen_string_literal: true

Given(/^the provider has (\d) active docs?$/) do |number_active_docs|
  @active_docs = FactoryGirl.create_list(:api_docs_service, number_active_docs.to_i, account: @provider, service: @provider.default_service)
end

When /^I try to create an active docs( for a service)? with invalid data$/ do |optional_scope|
  step "I go to the new active docs page#{optional_scope}"
  fill_in('Name', with: 'ActiveDocsName')
  fill_in('API JSON Spec', with: '{"basePath": "invalid", "apis": "invalid"}')
  click_on 'Create Service'
end

When /^I try to update an active docs( for a service)? with invalid data$/ do |optional_scope|
  step "I go to the edit active docs page#{optional_scope}"
  fill_in('API JSON Spec', with: '{"basePath": "invalid", "apis": "invalid"}')
  click_on 'Update Service'
end

Then 'I should see the errors in the page' do
  step 'I should see "JSON Spec is invalid"'
end

Then /^the table (should|should not) contain the API$/ do |action|
  step "I #{action} see \"API\" within the table header"
  step "I #{action} see \"#{@provider.default_service.name}\" within the table body"
end

Then(/^the service selector (is|is not) in the form$/) do |action|
  has_xpath = has_xpath? '//form//select[@id="api_docs_service_service_id"]'
  action == 'is' ? assert(has_xpath) : refute(has_xpath)
end

Then(/^the swagger autocomplete should work for "(.*?)" with "(.*?)"$/) do |input_name, autocomplete|
  click_on 'get'
  assert_equal 1, evaluate_script("$('input[name=#{input_name}]').focus().length")
  assert_equal 1, evaluate_script("$('.apidocs-param-tips.#{autocomplete}:visible').length")
end

Then 'I fill in the API JSON Spec with:' do |spec|
  selector = 'textarea#api_docs_service_body ~ .CodeMirror'

  find(:css, selector)

  page.evaluate_script <<-JS
    document.querySelector(#{selector.to_json}).CodeMirror.setValue(#{spec.to_json})
  JS
end
