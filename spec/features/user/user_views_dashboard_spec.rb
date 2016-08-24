require 'rails_helper'

RSpec.feature 'User views their dashboard' do
  scenario 'logged-in registered customer' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)

    visit dashboard_path

    within('table') do
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.date_registered)
      expect(page).to have_content(user.orders.count)
    end

    expect(page).to have_link('Manage My Account')
    expect(page).to have_link('View My Orders')
  end
end
