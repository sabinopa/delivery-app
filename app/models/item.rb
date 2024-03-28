class Item < ApplicationRecord
  belongs_to :category
  belongs_to :menu


  validates :name, :description, :price, presence: true
end
