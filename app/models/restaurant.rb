class Restaurant < ApplicationRecord
  belongs_to :owner
  has_many :opening_hours
  has_and_belongs_to_many :payment_methods


  accepts_nested_attributes_for :payment_methods
  accepts_nested_attributes_for :opening_hours
end
