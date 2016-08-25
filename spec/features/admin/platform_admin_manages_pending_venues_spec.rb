require 'rails_helper'

RSpec.feature "Platform admin manages pending venues" do
  context "currently pending venues exist" do
    scenario "logged-in platform admin approves pending venue" do
      pending = create_list(:offline_venue, 2)
      admin = create(:platform_admin)

      pending.first.admin.roles.delete(Role.find_by_name("venue_admin"))

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      within("#pending") do
        expect(page).to have_content pending.first.name
        expect(page).to have_content pending.last.name
      end

      expect(pending.first.admin.roles.exists?(name: "venue_admin")).to eq false

      within("#venue-#{pending.first.id}") do
        click_on "Approve"
      end

      expect(page).to have_content "#{pending.first.name} Approved!"

      within("#pending") do
        expect(page).to_not have_content pending.first.name
        expect(page).to have_content pending.last.name
      end

      expect(pending.first.admin.roles.exists?(name: "venue_admin")).to eq true

      visit venues_path

      expect(page).to have_content pending.first.name
    end

    scenario "logged-in platform admin decline pending venue" do
      pending = create_list(:offline_venue, 2)
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      within("#venue-#{pending.first.id}") do
        click_on "Decline"
      end

      expect(page).to have_content "#{pending.first.name} Declined!"

      within("#pending") do
        expect(page).to_not have_content pending.first.name
        expect(page).to have_content pending.last.name
      end

      visit venues_path

      expect(page).to_not have_content pending.first.name
      expect(User.count).to eq 3
      expect(Venue.count).to eq 1
    end
  end

  context "no pending venues exist" do
    scenario "logged-in platform admin visits admin dashboard" do
      admin = create(:platform_admin)

      allow_any_instance_of(ApplicationController).
        to receive(:current_user).
        and_return(admin)

      visit admin_dashboard_index_path

      within("#pending") do
        expect(page).to have_content "There are no venues currently pending. \
          Get out there and recruit!"
      end
    end
  end
end
