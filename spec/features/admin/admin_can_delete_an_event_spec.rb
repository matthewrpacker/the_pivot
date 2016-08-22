require 'rails_helper'

RSpec.feature "Admin can delete an event" do
  context "registered Venue Admin" do
    scenario "when they click Delete on venue show page" do
      event = create(:event)
      venue = event.venue
      admin = venue.admin
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      click_on "View My Events"

      expect(current_path).to eq(venue_path(venue))

      within("#event-#{event.id}") do
        click_on "Delete"
      end

      expect(current_path).to eq(venue_path(venue))
      expect(page).to have_content("Event Removed Successfully!")
      expect(page).to_not have_content(event.title)
    end

    scenario "when they click Delete on specific event show page" do
      event = create(:event)
      venue = event.venue
      admin = venue.admin
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit event_path(event.venue, event)

      click_on "Delete"

      expect(current_path).to eq(venue_path(venue))
      expect(page).to have_content("Event Removed Successfully!")
      expect(page).to_not have_content(event.title)
    end
  end

  context "registered customer" do
    scenario "they visit the venue show page" do
      user = create(:user)
      event = create(:event)
      venue = event.venue
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit venue_path(venue)

      expect(page).to_not have_button("Delete")
    end

    scenario "they visit the event show page" do
      user = create(:user)
      event = create(:event)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit event_path(event.venue, event)

      expect(page).to_not have_button("Delete")
    end
  end
end
