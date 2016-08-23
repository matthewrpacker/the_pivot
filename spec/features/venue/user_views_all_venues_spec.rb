require 'rails_helper'

RSpec.feature 'User views all venues' do
  scenario 'A guest user visits the root path' do
    venues = create_list(:venue, 2)
    visit root_path
    click_on 'Venues'

    expect(current_path).to eq(venues_path)
    expect(page).to have_content(venues.first.name)
    expect(page).to have_content(venues.last.name)
  end

  scenario 'offline venue' do
    offline_venue = create(:offline_venue)

    visit venues_path

    expect(page).to_not have_content(offline_venue.name)
  end
end
