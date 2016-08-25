require 'rails_helper'

RSpec.describe Venue, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_many(:events).dependent(:destroy) }
  it { should have_many(:categories).through(:events) }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_presence_of :slug }
  it { should validate_uniqueness_of(:slug).case_insensitive }
  it { should have_attached_file :upload_image }
  it { should validate_attachment_content_type(:upload_image).
       allowing('image/png', 'image/gif', 'image/jpg', 'image/jpeg').
       rejecting('text/plain', 'text/xml', 'text/html')}

  it "should be able to display its location" do
    venue = create(:venue)
    expect(venue.location).to eq("#{venue.city}, #{venue.state}")
  end

  it "can have status of online or offline" do
    online = create(:venue)
    offline = create(:offline_venue)
    expect(online.status).to eq('online')
    expect(offline.status).to eq('offline')
  end
end
