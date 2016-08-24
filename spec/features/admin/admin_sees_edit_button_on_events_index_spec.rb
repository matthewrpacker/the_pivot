require 'rails_helper'

RSpec.feature "Admin sees edit button on events index" do
  context "logged-in venue admin" do
    scenario "they only see an edit button for their events" do
      events = create_list(:event, 2)
      admin = events.first.venue.admin
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit events_path

      within("#event-#{events.first.id}") do
        expect(page).to have_link("Edit")
      end

      within("#event-#{events.last.id}") do
        expect(page).to_not have_link("Edit")
      end
    end
  end

  context "logged-in platform admin" do
    scenario "they see an edit button for all events" do
      events = create_list(:event, 2)
      admin = create(:platform_admin)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit events_path

      within("#event-#{events.first.id}") do
        expect(page).to have_link("Edit")
      end

      within("#event-#{events.last.id}") do
        expect(page).to have_link("Edit")
      end
    end
  end
end
