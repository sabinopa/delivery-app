class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :items
  has_many :categories, through: :items

  validates :name, :description, presence: true

  accepts_nested_attributes_for :items
end
