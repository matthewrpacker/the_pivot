require 'rails_helper'

RSpec.feature 'Admin creates an event' do
  context 'logged-in event admin' do
    scenario 'with valid event information' do
      venue = create(:venue)
      admin = venue.admin
      categories = create_list(:category, 3)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      expect(venue.events.count).to eq(0)

      visit admin_dashboard_index_path
      click_on 'View My Events'
      click_on 'Add New Event'

      expect(current_path).to eq(new_admin_event_path)
      within('form') do
        expect(page).to_not have_content('Venue')
      end

      fill_in 'Title', with: 'Colorado Rapids'
      fill_in 'Supporting Act', with: 'LA Galaxy'
      fill_in 'Price', with: 44.99
      fill_in 'Date', with: '2016/09/12'
      select categories.first.title, from: 'Category'
      click_on 'Add Event'

      expect(current_path).
        to eq(event_path(Event.first.venue, Event.first))
      expect(page).to have_content('Event Added Successfully!')
      expect(page).to have_content('Colorado Rapids')
      expect(page).to have_content('LA Galaxy')
      expect(page).to have_content('$44.99')
      expect(page).to have_content('09-12-2016')
      expect(page).
        to have_css("img[src*='#{Event.first.venue.image_path}']")
      expect(venue.events.count).to eq(1)
    end

    scenario 'with invalid event information' do
      venue = create(:venue)
      admin = venue.admin
      existing_event = create(:event)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit events_path
      click_on 'Add New Event'
      fill_in 'Title', with: existing_event.title
      click_on 'Add Event'

      expect(page).to have_content("Price can't be blank")
      expect(Event.count).to eq(1)
    end
  end

  # Test is skipped due to this functionality currently being tentative
  # context 'with valid information and photo' do
  #   scenario 'logged-in admin visits the events path' do
  #     admin = create(:admin)
  #     categories = create_list(:category, 3)
  #     venue = create(:venue)
  #
  #     allow_any_instance_of(ApplicationController).
  #       to receive(:current_user).
  #       and_return(admin)
  #
  #     visit events_path
  #     click_on 'Add New Event'
  #
  #     fill_in 'Title', with: 'Foo Fighters'
  #     fill_in 'Supporting Act', with: "Freedom Fighters"
  #     fill_in 'Price', with: 29.99
  #     select "#{categories.first.title}", from: 'Category'
  #     select "#{venue.name}", from: 'Venue'
  #     # Commented out due to this being a static asset.
  #     # attach_file('Image', '/Users/Ryan/Desktop/sample.gif')
  #     click_on 'Add Event'
  #
  #     expect(current_path).
          # to eq(event_path(Event.first.venue, Event.first))
  #     expect(page).to have_content(Event.first.title)
  #     expect(page).to have_content(Event.first.supporting_act)
  #     expect(page).to have_content(Event.first.price)
  #     expect(page).
          # to have_css("img[src*='#{Event.first.venue.image_path}']")
  #   end
  # end

  context 'unauthorized user' do
    scenario "logged-in venue admin can't create other venue event" do
      venues = create_list(:venue, 2)
      admin = venues.first.admin

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit new_admin_event_path
      within('form') do
        expect(page).to_not have_content('Venue')
      end
    end

    scenario 'logged-in user visits the events path' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit events_path

      expect(page).to_not have_button('Add New Event')
    end

    scenario 'logged-in user attempts to visit new event path' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit new_admin_event_path

      expect(current_path).to eq(new_admin_event_path)
      expect(page).
        to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
    end

    scenario 'visitor visits the events path' do
      visit events_path

      expect(page).to_not have_button('Add New Event')
    end

    scenario 'visitor attempts to visit new event path' do
      visit new_admin_event_path

      expect(current_path).to eq(new_admin_event_path)
      expect(page).
        to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
    end
  end
end
