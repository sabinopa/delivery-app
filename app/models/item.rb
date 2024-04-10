class Item < ApplicationRecord
  belongs_to :category
  belongs_to :menu

  validates :name, :description, :price, presence: true

  enum status: { active: 0, inactive: 1 }
end
