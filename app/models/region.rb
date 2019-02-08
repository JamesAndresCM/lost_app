# == Schema Information
#
# Table name: regions
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  iso_code      :string
#  region_number :string
#

class Region < ApplicationRecord
  has_many :provinces, dependent: :destroy, inverse_of: :region
  has_many :districts, through: :provinces
  has_many :posts, through: :districts
end
