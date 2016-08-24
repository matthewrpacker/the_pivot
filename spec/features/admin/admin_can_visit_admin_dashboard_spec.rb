require 'rails_helper'

RSpec.feature "Admin can view dashboard" do
  context "registered venue admin" do
    scenario "they visit their dashboard index" do
      venue = create(:venue)
      admin = venue.admin

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      expect(current_path).to eq(admin_dashboard_index_path)
      expect(page).to have_content "Admin Dashboard"
      within ('#user_dashboard') do
        expect(page).to have_content admin.username
        expect(page).to have_content admin.email
        expect(page).to have_content admin.date_registered
        expect(page).to have_content venue.name
      end
      expect(page).to have_link "Manage My Account"
      expect(page).to have_link "Manage Events"

      expect(page).not_to have_content "You cannot access admin content!"
    end
  end

  context "registered platform admin" do
    scenario "they can visit their dashboard index" do
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      within ('#user_dashboard') do
        expect(page).to have_content admin.username
        expect(page).to have_content admin.email
        expect(page).to have_content admin.date_registered
      end
      expect(page).to have_link "Manage My Account"
      expect(page).to have_link "Manage Venues"
      expect(page).to have_content "Pending Venues"
    end
  end
end
