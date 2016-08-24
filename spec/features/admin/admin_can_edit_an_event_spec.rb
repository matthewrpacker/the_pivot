require 'rails_helper'

RSpec.feature "Admin can edit an event" do
  context "registered venue admin" do
    scenario "they visit their dashboard with valid event updates" do
      event = create(:event)
      admin = event.venue.admin
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path
      click_on "View My Events"

      within("#event-#{event.id}") do
        click_on "Edit"
      end

      expect(current_path).to eq(edit_admin_event_path(event))
      fill_in "Title", with: "The Book of Mormon"
      click_on "Update Event"

      expect(current_path).
        to eq(event_path(Event.first.venue, Event.first))
      expect(page).to have_content("Event Updated Successfully!")
      within('.event-content') do
        expect(page).to_not have_content(event.title)
        expect(page).to have_content("The Book of Mormon")
        expect(page).to have_content(event.venue_name)
        expect(page).to have_content(event.category.title)
        expect(page).to have_content(event.supporting_act)
        expect(page).to have_content(event.event_date)
        expect(page).to have_content(event.price)
      end
    end

    scenario "with invalid event updates" do
      event = create(:event)
      admin = event.venue.admin
      existing_event = Event.create(
        title: "Already Here",
        price: 9.99,
        category: event.category,
        venue: event.venue,
        date: event.date,
        supporting_act: event.supporting_act
      )

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit edit_admin_event_path(event)
      fill_in "Title", with: existing_event.title
      fill_in "Date", with: existing_event.date
      click_on "Update Event"

      expect(page).to have_content('Title has already been taken')
      expect(Event.first.title).to eq(event.title)
    end

    scenario "they attempt to edit another venue's event" do
      events = create_list(:event, 2)
      admin = events.first.venue.admin

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit edit_admin_event_path(Event.last)

      expect(page).to_not have_content("Edit Event")
      expect(page).to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
    end
  end

  context "registered customer" do
    scenario "they attempt to visit the edit event path" do
      user = create(:user)
      event = create(:event)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit edit_admin_event_path(event)

      expect(page).to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
    end
  end
end
