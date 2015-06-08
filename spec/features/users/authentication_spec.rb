require 'spec_helper'
RSpec.configure do |c|
  c.expose_current_running_example_as :example
end

describe "Logging in" do
  it "logs the user in and goes to the todo lists" do
    User.create(first_name: "Seth", last_name: "Kroger", 
                email: "seth@example.com", password: "12345", password_confirmation: "12345")
    visit new_user_session_path
    fill_in "Email address", with: "seth@example.com"
    fill_in "Password", with: "12345"
    click_button "Log In"
    
    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in!")
  end
  
  it "displays the email address in the event of a failed login" do
    visit new_user_session_path
    fill_in "Email address", with: "seth@example.com"
    fill_in "Password", with: "incorrect"
    click_button "Log In"
    
    expect(page).to have_content("There was a problem logging in. Please check your email and password.")
    expect(page).to have_field("Email address", with: "seth@example.com")
  end
end