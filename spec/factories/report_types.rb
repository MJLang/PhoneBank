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

FactoryGirl.define do
  factory :report_type do
    name "MyString"
phone_call_weight "9.99"
text_message_weight "9.99"
  end

end
