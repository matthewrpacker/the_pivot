class Venue < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :categories, through: :events
  has_attached_file :upload_image,
                    default_url: 'http://i.imgur.com/5p6sEsX.jpg'
  belongs_to :admin, class_name: "User", foreign_key: :user_id
  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
  validates :state, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates_attachment_content_type :upload_image,
                                    :content_type => /\Aimage\/.*\Z/
  before_validation :create_slug

  after_create :set_image_path

  enum status: %w(online offline)

  def location
    "#{city}, #{state}"
  end

  def to_param
    slug
  end

  def update_image_path
    unless upload_image.url == 'http://i.imgur.com/5p6sEsX.jpg'
      update_image
    end
  end

  def set_image_path
    update_image unless image_path
  end

  private

  def create_slug
    self.slug = name.parameterize if name
  end

  def update_image
    update(image_path: upload_image.url)
  end
end
