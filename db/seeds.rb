class Seed
  def initialize
    create_roles
    create_categories
    create_venues
    create_nate_venue_admin
    create_venue_admins
    create_events
    create_josh_customer
    create_customers
    create_orders
    create_jorge_platform_admin
  end

  private

  def create_roles
    Role.create!(name: 'registered_customer')
    puts "Registered Customer role created."
    Role.create!(name: 'venue_admin')
    puts "Venue Admin role created."
    Role.create!(name: 'platform_admin')
    puts "Platform Admin role created."
  end

  def create_categories
    Category.create!(title: "Music")
    puts "Category #{Category.last.title} created."
    Category.create!(title: "Sports")
    puts "Category #{Category.last.title} created."
    Category.create!(title: "Theater")
    puts "Category #{Category.last.title} created."
    Category.create!(title: "Meet-Up")
    puts "Category #{Category.last.title} created."
    Category.create!(title: "Conference")
    puts "Category #{Category.last.title} created."
    Category.create!(title: "Art")
    puts "Category #{Category.last.title} created."
    Category.create!(title: "Lectures")
    puts "Category #{Category.last.title} created."
    Category.create!(title: "Film")
    puts "Category #{Category.last.title} created."
    Category.create!(title: "Comedy")
    puts "Category #{Category.last.title} created."
    Category.create!(title: "Carnival")
    puts "Category #{Category.last.title} created."
  end

  def create_venues
    Venue.create!(
      name: 'Wrigley Field',
      city: 'Chicago',
      state: 'IL',
      capacity: 41268,
      image_path: 'http://i.imgur.com/NqWzxPB.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Red Rocks Amphitheatre',
      city: 'Morrison',
      state: 'CO',
      capacity: 9525,
      image_path: 'http://i.imgur.com/JGQP86m.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Yankee Stadium',
      city: 'Bronx',
      state: 'NY',
      capacity: 54251,
      image_path: 'http://i.imgur.com/6kpS9z5.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Bellco Theatre',
      city: 'Denver',
      state: 'CO',
      capacity: 5000,
      image_path: 'http://i.imgur.com/SIccgUE.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Walt Disney Concert Hall',
      city: 'Los Angeles',
      state: 'CA',
      capacity: 2265,
      image_path: 'http://i.imgur.com/3FT6OWs.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Carnegie Hall',
      city: 'New York',
      state: 'NY',
      capacity: 2804,
      image_path: 'http://i.imgur.com/7kSGPAh.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Sydney Opera House',
      city: 'Sydney',
      state: 'AU',
      capacity: 6000,
      image_path: 'http://i.imgur.com/ZhZQ5qw.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Madison Square Garden',
      city: 'New York',
      state: 'NY',
      capacity: 18200,
      image_path: 'http://i.imgur.com/AlRnvKR.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Pepsi Center',
      city: 'Denver',
      state: 'CO',
      capacity: 18007,
      image_path: 'http://i.imgur.com/7OeaBay.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Gorge Amphitheatre',
      city: 'George',
      state: 'WA',
      capacity: 27500,
      image_path: 'http://i.imgur.com/Mzv1JU5.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Museum of Modern Art',
      city: 'New York',
      state: 'NY',
      capacity: 5251,
      image_path: 'http://i.imgur.com/APMN5QN.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'San Diego Convention Center',
      city: 'San Diego',
      state: 'CA',
      capacity: 125000,
      image_path: 'http://i.imgur.com/81CNDWf.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Beaver Stadium',
      city: 'State College',
      state: 'PA',
      capacity: 107282,
      image_path: 'http://i.imgur.com/9OcLwCU.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'University of Phoenix Stadium',
      city: 'Glendale',
      state: 'AZ',
      capacity: 63400,
      image_path: 'http://i.imgur.com/niiHcUO.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Minnesota State Fairgrounds',
      city: 'St. Paul',
      state: 'MN',
      capacity: 17000,
      image_path: 'http://i.imgur.com/zIJMgUm.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'PNC Park',
      city: 'Pittsburgh',
      state: 'PA',
      capacity: 38362,
      image_path: 'http://i.imgur.com/ZhpUui3.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'AT&T Stadium',
      city: 'Arlington',
      state: 'TX',
      capacity: 80000,
      image_path: 'http://i.imgur.com/Q5qbKTi.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Rungrado 1st of May Stadium',
      city: 'Pyongyang',
      state: 'NK',
      capacity: 150000,
      image_path: 'http://i.imgur.com/LqQAAeN.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Mall of Asia Arena',
      city: 'Manila',
      state: 'PI',
      capacity: 20000,
      image_path: 'http://i.imgur.com/hRFfDRE.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
    Venue.create!(
      name: 'Camp Nou',
      city: 'Barcelona',
      state: 'SP',
      capacity: 99354,
      image_path: 'http://i.imgur.com/piLqdVD.jpg',
      status: 0
      )
      puts "Venue #{Venue.last.name} created."
  end

  def create_events
    Category.all.each do |category|
      50.times do |i|
        Event.create!(
          title: "#{Faker::Book.title} #{Faker::Company.profession.capitalize}",
          supporting_act: Faker::App.author,
          price: Faker::Commerce.price,
          image_path: "http://robohash.org/#{i}.png?set=set2&bgset=bg1&size=200x200",
          category: category,
          venue: Venue.offset(rand(Venue.count)).first,
          date: Faker::Time.forward(150, :evening)
        )
        puts "#{category.title}: Event #{i + 1} created."
      end
    end
  end

  def create_josh_customer
    User.create!(
      username: "jmejia@turing.io",
      email: "jmejia@turing.io",
      password: "password"
    )
    User.last.roles << Role.find_by(name: 'registered_customer')
    puts "Customer Josh created."
  end

  def create_nate_venue_admin
    User.create!(
      username: "nate@turing.io",
      email: "nate@turing.io",
      password: "password",
    )
    User.last.roles << Role.where.not(name: 'platform_admin')
    puts "Venue Admin Nate created."
  end

  def create_customers
    99.times do |i|
      User.create!(
        username: "#{Faker::Internet.user_name}_#{i}",
        email: "#{i + 1}_#{Faker::Internet.safe_email}",
        password: "password"
      )
      User.last.roles << Role.find_by(name: 'registered_customer')
      puts "Customer #{i + 1} created."
    end
  end

  def create_venue_admins
    19.times do |i|
      User.create!(
        username: "#{Faker::Internet.user_name}_admin_#{i + 1}",
        email: "admin_#{i + 1}_#{Faker::Internet.safe_email}",
        password: "password"
      )
      User.last.roles << Role.find_by(name: 'venue_admin')
      puts "Venue Admin #{i + 1} created."
    end
    Venue.all.each_with_index do |venue, index|
      venue.update(admin: User.offset(index).first)
    end
  end

  def create_orders
    User.all.each do |user|
      unless user.roles.exists?(name: 'venue_admin')
        10.times do |i|
          order = user.orders.create!
          events = Event.offset(i).limit(rand(1..10))
          order.events << events
          events.each do |event|
            order_item = OrderEvent.find_by(order: order, event: event)
            order_item.update(quantity: rand(1..10))
          end
          puts "#{user.username}: Order #{i + 1} created."
        end
      end
    end
  end

  def create_jorge_platform_admin
    User.create!(
      username: "jorge@turing.io",
      email: "jorge@turing.io",
      password: "password",
    )
    User.last.roles << Role.all
    puts "Platform Admin Jorge created."
  end
end

Seed.new
