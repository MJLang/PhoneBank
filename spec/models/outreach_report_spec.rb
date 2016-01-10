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

require 'rails_helper'

RSpec.describe OutreachReport, type: :model do
end
