require 'rails_helper'

RSpec.feature "User can view past orders" do
  context "they go to their Order History page" do
    scenario "when they have previous orders" do
      user = create(:user)
      create(:event)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit events_path

      click_on "Add to Cart"
      click_on "Add to Cart"

      visit cart_index_path

      click_on "Checkout"

      order = Order.first

      within("#order-#{order.id}") do
        expect(page).to have_content(order.date)
        expect(page).to have_content(order.total_tickets)
        expect(page).to have_content(order.total)
      end
    end

    scenario "when they don't have any previous orders" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(user)

      visit orders_path

      expect(page).to have_content("You have no orders yet " \
        "Time to make some memories at one of the many incredible " \
        "events coming soon!")
      expect(page).
        to have_css('img[src*="https://i.imgur.com/ldtpOON.gif"]')
    end
  end
end
