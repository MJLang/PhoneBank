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
#  state           :string
#

class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true,
                    presence: true

  validates :display_name, uniqueness: true,
                           presence: true

  has_many :outreach_reports
  has_one :membership, dependent: :destroy
  has_one :team, through: :membership

  before_save :generate_slug

  def to_s
    display_name.nil? ? email : display_name
  end

  def generate_slug
    self.slug = display_name.to_param
  end

  def is_member?(team)
    self.team == team
  end

  def is_admin?(team)
    return false if self.team.nil?
    self.membership.admin == true
  end

end
