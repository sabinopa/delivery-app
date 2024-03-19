class Restaurant < ApplicationRecord
  has_and_belong_to_many :payment_methods

  accepts_nested_attributes_for :payment_method
end
