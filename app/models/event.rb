class Event < ApplicationRecord
  belongs_to :category
  belongs_to :venue
  has_many :order_events
  has_many :orders, through: :order_events
  validates :title, presence: true, uniqueness: { scope: [:venue_id, :date] }
  validates :price, presence: true, :numericality => {:greater_than => 0}
  validates :category, presence: true
  validates :venue, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  before_validation :create_slug

  enum status: %w(upcoming occurred)

  def venue_name
    venue.name
  end

  def venue_location
    venue.location
  end

  def past_event?
    status == 'occurred'
  end

  def to_param
    slug
  end

  def event_date
    date.strftime("%m-%d-%Y")
  end

  private

  def create_slug
    self.slug = "#{title.parameterize}-#{event_date}" if title
  end

end
