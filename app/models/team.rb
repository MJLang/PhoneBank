# == Schema Information
#
# Table name: teams
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :string
#  fundraising_url :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  division_id     :integer
#

class Team < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: 'user'

  belongs_to :team

  validates :name, uniqueness: true,
                   presence: true

  def add_member(user)
    members << user
  end

  def add_admin(user)
    memberships.create({user: user, admin: true})
  end

  def is_member?(user)
    members.include?(user)
  end

  def is_admin?(user)
    memberships.includes(:user).where({admin: true}).collect(&:user).include?(user)
  end

end
