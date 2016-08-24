require 'rails_helper'

RSpec.feature "Visitor can use cancel buttons" do
  scenario "visitor clicks cancel from login page" do
    visit root_path
    click_on "Login"

    expect(current_path).to eq login_path

    click_on "Cancel"

    expect(current_path).to eq root_path

    visit venue_path(':red-rocks')
    click_on "Login"

    expect(current_path).to eq login_path

    click_on "Cancel"

    expect(current_path).to eq venue_path(':red-rocks')
  end

  scenario "visitor clicks cancel from create account page" do
    visit login_path
    click_on "Create an account"

    expect(current_path).to eq new_user_path

    click_on "Cancel"

    expect(current_path).to eq login_path
  end

  scenario "visitor clicks cancel from sell with us page" do
    visit root_path
    click_on "Sell With Us"

    expect(current_path).to eq login_path

    click_on "Cancel"

    expect(current_path).to eq root_path
  end
end
