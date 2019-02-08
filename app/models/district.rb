# == Schema Information
#
# Table name: districts
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  code        :string
#  province_id :bigint(8)
#

class District < ApplicationRecord
  belongs_to :province, inverse_of: :districts
  has_many :posts, inverse_of: :district
  has_one :region, through: :province
end
