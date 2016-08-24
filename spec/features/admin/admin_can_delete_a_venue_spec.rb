require 'rails_helper'

RSpec.feature "Platform Admin can delete a venue" do
  context "logged in Platform Admin" do
    scenario "they click Delete on venue show page" do
      venue = create(:venue)
      admin = create(:platform_admin)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit venue_path(venue)

      click_on "Delete Venue"

      expect(current_path).to eq(venues_path)
      expect(page).to have_content("#{venue.name} Removed!")
      within(".page-content") do
        expect(page).to_not have_content(venue.name)
      end
    end

    scenario "they click Delete on specific venue on venue index" do
      venues = create_list(:venue, 2)
      admin = create(:platform_admin)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      click_on "Manage Venues"

      within "#venue-#{venues.first.id}" do
        click_on "Delete"
      end

      expect(current_path).to eq(venues_path)
      expect(page).to have_content("#{venues.first.name} Removed!")
      within(".page-content") do
        expect(page).to_not have_content(venues.first.name)
      end
    end
  end
end
