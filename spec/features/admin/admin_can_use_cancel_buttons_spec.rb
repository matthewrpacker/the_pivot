require 'rails_helper'

RSpec.feature "Admin can use cancel buttons" do
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

    click_on "View My Events"

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
