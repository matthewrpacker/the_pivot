class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  validates :username, presence: true, uniqueness: true, if: "uid.nil?", on: :create
  validates :email, presence: true, if: "uid.nil?", on: :create
  validates :email, email: { strict_mode: true }, if: "uid.nil?", on: :create

  def date_registered
    created_at.strftime("%m/%d/%Y")
  end

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid             = auth_info.uid
      new_user.username        = auth_info.extra.raw_info.screen_name
      new_user.oauth_token     = auth_info.credentials.token
      new_user.password_digest = auth_info.credentials.secret
    end
  end

  def platform_admin?
    roles.exists?(name: 'platform_admin')
  end

  def venue_admin?
    roles.exists?(name: 'venue_admin')
  end

  def registered_customer?
    roles.exists?(name: 'registered_customer')
  end
end
