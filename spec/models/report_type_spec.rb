# == Schema Information
#
# Table name: report_types
#
#  id                  :integer          not null, primary key
#  name                :string
#  phone_call_weight   :decimal(, )
#  text_message_weight :decimal(, )
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe ReportType, type: :model do
end
