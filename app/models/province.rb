# == Schema Information
#
# Table name: provinces
#
#  id        :bigint(8)        not null, primary key
#  name      :string
#  region_id :bigint(8)
#

class Province < ApplicationRecord
  belongs_to :region, inverse_of: :provinces
  has_many :districts, dependent: :destroy
end
