require 'rails_helper'

RSpec.feature "Admin can use cancel buttons" do
  context "logged-in venue admin" do
    scenario "admin clicks cancel from manage account page" do
      venue = create(:venue)
      admin = venue.admin

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      click_on "Manage My Account"

      expect(page).to have_content "Edit Account"
      expect(current_path).to eq edit_user_path(admin)

      click_on "Cancel"

      expect(page).to have_content "Admin Dashboard"
      expect(current_path).to eq admin_dashboard_index_path
    end

    scenario "admin clicks cancel from manage venue page" do
      venue = create(:venue)
      admin = venue.admin

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      click_on "Manage Venue"

      expect(page).to have_content "Edit Venue"
      expect(current_path).to eq edit_admin_venue_path(venue.slug)

      click_on "Cancel"

      expect(current_path).to eq admin_dashboard_index_path
    end

    scenario "admin clicks cancel from new event page" do
      venue = create(:venue)
      admin = venue.admin

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit venue_path(venue.slug)

      click_on "Add New Event"

      expect(page).to have_content "Add New Event"
      expect(current_path).to eq new_admin_event_path

      click_on "Cancel"

      expect(current_path).to eq venue_path(venue.slug)
    end

    scenario "admin clicks cancel from new event page" do
      venue = create(:venue)
      admin = venue.admin

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      click_on "Manage Events"

      expect(page).to have_content venue.name
      expect(current_path).to eq venue_path(venue.slug)

      click_on "Back"

      expect(current_path).to eq admin_dashboard_index_path

      visit venues_path

      within "#venue-#{venue.id}" do
        click_on "View Venue"
      end

      expect(current_path).to eq venue_path(venue.slug)

      click_on "Back"

      expect(current_path).to eq venues_path
    end
  end

  context "logged-in platform admin" do
    scenario "platform admin clicks cancel from manage account page" do
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      click_on "Manage My Account"

      expect(current_path).to eq edit_user_path(admin)

      click_on "Cancel"

      expect(current_path).to eq admin_dashboard_index_path
    end

    scenario "admin clicks back from manage venues index page" do
      create(:venue)
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      click_on "Manage Venues"

      expect(current_path).to eq venues_path

      click_on "Back"

      expect(current_path).to eq admin_dashboard_index_path
    end

    scenario "admin clicks back from manage events index page" do
      create(:venue)
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      click_on "Manage Events"

      expect(current_path).to eq events_path

      click_on "Back"

      expect(current_path).to eq admin_dashboard_index_path

      visit venues_path

      click_on "All Events"

      expect(current_path).to eq events_path

      click_on "Back"

      expect(current_path).to eq venues_path
    end

    scenario "admin clicks cancel from new event page" do
      create(:venue)
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit events_path

      click_on "Add New Event"

      expect(current_path).to eq new_admin_event_path

      click_on "Cancel"

      expect(current_path).to eq events_path
    end

    scenario "admin clicks cancel from new event page for a specific venue" do
      venue = create(:venue)
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit venue_path(venue.slug)

      click_on "Add New Event"

      expect(current_path).to eq new_admin_event_path

      click_on "Cancel"

      expect(current_path).to eq venue_path(venue.slug)
    end

    scenario "admin clicks back from view venue page" do
      venue = create(:venue)
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit venues_path

      within "#venue-#{venue.id}" do
        click_on "View Venue"
      end

      expect(current_path).to eq venue_path(venue.slug)

      click_on "<< Back"

      expect(current_path).to eq venues_path
    end

    scenario "admin clicks cancel from edit venue page" do
      venue = create(:venue)
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit venues_path

      within "#venue-#{venue.id}" do
        click_on "Edit"
      end

      expect(current_path).to eq edit_admin_venue_path(venue.slug)

      click_on "Cancel"

      expect(current_path).to eq venues_path

      visit venue_path(venue.slug)

      click_on "Edit Venue"

      expect(current_path).to eq edit_admin_venue_path(venue.slug)

      click_on "Cancel"

      expect(current_path).to eq venue_path(venue.slug)
    end

    scenario "admin clicks cancel from edit venue admin page" do
      venue = create(:venue)
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit venue_path(venue.slug)

      click_on "Edit"

      expect(current_path).to eq edit_user_path(venue.user_id)

      click_on "Cancel"

      expect(current_path).to eq venue_path(venue.slug)
    end

    scenario "admin clicks cancel from edit event page" do
      event = create(:event)
      create(:venue)
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit event_path(event.venue, event)

      click_on "Edit"

      expect(current_path).to eq edit_admin_event_path(event)

      click_on "Cancel"

      expect(current_path).to eq event_path(event.venue, event)

      visit events_path

      within("#event-#{event.id}") do
        click_on "Edit"
      end

      expect(current_path).to eq(edit_admin_event_path(event))

      click_on "Cancel"

      expect(current_path).to eq events_path
    end
  end
end
