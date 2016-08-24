require 'rails_helper'

RSpec.feature "User can use cancel buttons" do
  scenario "user clicks cancel from manage account page" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)

    visit dashboard_path

    click_on "Manage My Account"

    expect(page).to have_content "Edit Account"
    expect(current_path).to eq edit_user_path(user)

    click_on "Cancel"

    expect(page).to have_content "Profile for #{user.username}"
    expect(current_path).to eq dashboard_path
  end

  scenario "user clicks cancel from venue application page" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)

    visit new_venue_path

    expect(page).to have_content "Venue Application"

    click_on "Cancel"

    expect(page).to have_content "Profile for #{user.username}"
    expect(current_path).to eq dashboard_path
  end
end
