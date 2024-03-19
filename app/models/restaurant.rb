class Restaurant < ApplicationRecord
  has_one :payment_method
end
