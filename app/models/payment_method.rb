class PaymentMethod < ApplicationRecord
  has_and_belong_to_many :restaurants
end
