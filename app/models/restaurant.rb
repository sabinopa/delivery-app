class Restaurant < ApplicationRecord
  belongs_to :owner
  has_and_belongs_to_many :payment_methods

  validates :brand_name, :corporate_name, :registration_number, :phone_number,
            :email, :address, :neighborhood, :city, :state, :zipcode, :description,
            presence: true

  accepts_nested_attributes_for :payment_methods
end
