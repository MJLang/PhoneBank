# == Schema Information
#
# Table name: outreach_reports
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  text_messages :integer
#  phone_calls   :integer
#  comments      :text
#  experience    :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OutreachReport < ActiveRecord::Base
  belongs_to :user
end
