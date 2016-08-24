require 'rails_helper'

RSpec.feature "User can edit account" do
  scenario "user edits account from dashboard" do
    user = create(:user)

    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: 'password'

    click_button "Login"
    click_on "Manage My Account"

    fill_in "Username", with: "Matt"
    fill_in "Email", with: "matt@example.com"
    fill_in "Password", with: "password1"

    click_on "Update Account"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Matt")
    expect(page).to have_content("matt@example.com")
    expect(page).to have_no_content(user.username)
  end
end
