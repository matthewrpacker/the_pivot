require 'rails_helper'

RSpec.feature "User information is secure from others" do
  context "guest user" do
    scenario "guest attempts to visit a user's show page" do
      place_order

      visit order_path(Order.first)

      expect(page).
        to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
      expect(page).to have_content("Not expecting this message? \
        Try logging in.")
    end

    scenario "guest attempts to visit the dashboard" do
      visit dashboard_path

      expect(page).
        to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
      expect(page).to have_content("Not expecting this message? \
        Try logging in.")
    end

    scenario "guest attempts to visit the orders path" do
      visit orders_path

      expect(page).
        to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
      expect(page).to have_content("Not expecting this message? \
        Try logging in.")
    end

    scenario "guest attemps to visit the admin dashboard" do
      visit admin_dashboard_index_path

      expect(page).
        to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
      expect(page).to have_content("Not expecting this message? \
        Try logging in.")
    end

    scenario "guest attempts to view the edit user path" do
      create(:user)

      visit edit_user_path(User.first)

      expect(page).
        to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
      expect(page).to have_content("Not expecting this message? \
        Try logging in.")
    end
  end

  context "logged-in registered customer" do
    scenario "they attempt to visit another user's order page" do
      place_order
      nefarious_user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(nefarious_user)

      visit order_path(Order.first)

      expect(page).
        to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
    end

    scenario "they attempt to visit the admin dashboard" do
      nefarious_user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(nefarious_user)

      visit admin_dashboard_index_path

      expect(page).
        to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
    end

    scenario "they attempt to visit the edit page for another user" do
      innocent_user = create(:user)
      nefarious_user = create(:user)
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(nefarious_user)

      visit edit_user_path(innocent_user)

      expect(page).
        to have_css('img[src*="http://i.imgur.com/F4zRA3g.jpg"]')
    end
  end
end

private

def place_order
  user = create(:user)
  create(:event)

  visit login_path
  within('form') do
    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'password'
    click_on 'Login'
  end

  visit events_path
  click_on "Add to Cart"
  click_on "Add to Cart"

  visit cart_index_path
  click_on "Checkout"

  click_on 'Logout'
end
