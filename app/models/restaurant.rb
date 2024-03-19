class Restaurant < ApplicationRecord
  has_one :payment_method

  accepts_nested_attributes_for :payment_method
end
