require 'rails_helper'

RSpec.feature "Remove an event from the cart" do
  scenario "a visitor visits the cart path" do
    event = create(:event)

    visit events_path

    within ("#event-#{event.id}") do
      click_on "Add to Cart"
    end

    visit cart_index_path

    within("#event-#{event.id}") do
      click_on "Remove"
    end
    expect(current_path).to eq(cart_index_path)

    expect(page).to have_content("Successfully removed #{event.title} \
      from your cart.")
    expect(page).to have_link("#{event.title}",
      href: event_path(event.venue, event))

    within(".table-responsive") do
      expect(page).not_to have_content(event.title)
      expect(page).to have_content("Your cart is empty! Time to make \
        some memories at one of the many incredible events coming soon!")
      expect(page).to have_link("events", href: events_path)
    end
  end
end
