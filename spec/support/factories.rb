FactoryGirl.define do
  factory :event do
    title
    supporting_act "Norm Macdonald"
    price 199.99
    category
    venue
    date "2014-09-18 12:30:59 -0700"
    factory :sold_out_event do
      status 1
    end
  end

  factory :venue do
    name
    city 'Denver'
    state 'CO'
    capacity 500
    admin { create(:venue_admin) }
    status 0
    factory :offline_venue do
      status 1
    end
  end

  factory :category do
    title { generate(:category_title) }
  end

  factory :order do
    user
    events { create_list(:event, 2) }
  end

  factory :user do
    username
    email
    password 'password'
    roles { [ Role.find_or_create_by(name: 'registered_customer') ] }

    factory :venue_admin do
      roles {
        [
          Role.find_or_create_by(name: 'registered_customer'),
          Role.find_or_create_by(name: 'venue_admin')
        ]
      }
    end

    factory :platform_admin do
      roles {
        [
          Role.find_or_create_by(name: 'registered_customer'),
          Role.find_or_create_by(name: 'venue_admin'),
          Role.find_or_create_by(name: 'platform_admin')
        ]
      }
    end
  end

  sequence :username do |n|
    "user_#{n}"
  end

  sequence :email do |n|
    "user_#{n}@example.com"
  end

  sequence :name do |n|
    "Venue_#{n}"
  end

  sequence :category_title do |n|
    "Category_#{n}"
  end

  sequence :title do |n|
    "Event_#{n}"
  end
end
