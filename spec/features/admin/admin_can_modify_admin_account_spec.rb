require 'rails_helper'

RSpec.feature "Admin can modify their account" do
  context "registered venue admin" do
    scenario "they visit the login path" do
      venue = create(:venue)
      admin = venue.admin

      visit login_path

      fill_in "Username", with: admin.username
      fill_in "Password", with: 'password'
      click_button "Login"

      expect(current_path).to eq(admin_dashboard_index_path)
      expect(page).to have_content "Admin Dashboard"
      click_on "Manage My Account"
      expect(current_path).to eq(edit_user_path(admin))

      fill_in "Username", with: "ADMIN"
      fill_in "Email", with: admin.email
      fill_in "Password", with: 'password'
      click_button "Update Account"

      expect(page).to have_content "Logged in as ADMIN"
      expect(current_path).to eq(admin_dashboard_index_path)
    end
  end

  context "registered platform admin" do
    scenario "logged-in platform admin edits their account" do
      admin = create(:platform_admin)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      click_on "Manage My Account"

      fill_in "Username", with: "Cosmo"
      fill_in "Email", with: "assman@gmail.com"
      click_on "Update Account"

      expect(current_path).to eq(admin_dashboard_index_path)
    end

    scenario "logged-in platform admin edits a venue admin's account" do
      admin = create(:platform_admin)
      venues = create_list(:venue, 2)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      click_on "Manage Venues"

      within("#venue-#{venues.first.id}") do
        click_on "View Venue"
      end

      expect(page).
        to have_content("Venue Admin: #{venues.first.admin.username}")

      within('.venue-details') do
        click_on "Edit"
      end

      within('form') do
        expect(page).
          to have_selector("input[value='#{venues.first.admin.username}']")
        expect(page).
          to have_selector("input[value='#{venues.first.admin.email}']")
      end

      fill_in "Username", with: "george_costanza"
      fill_in "Email", with: "best_architect@vanderlay.com"
      click_on "Update Account"

      expect(current_path).to eq(venue_path(venues.first))
      expect(page).to have_content("Account Updated Successfully!")
      expect(page).to have_content("Venue Admin: george_costanza")
    end
  end
end
