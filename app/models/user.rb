# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  last_login      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  display_name    :string
#  slug            :string
#

class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true,
                    presence: true

  validates :display_name, uniqueness: true

  has_many :outreach_reports
  has_one :membership
  has_one :team, through: :membership

  before_save :generate_slug

  def to_s
    display_name.nil? ? email : display_name
  end

  def generate_slug
    self.slug = display_name.to_param
  end

end
