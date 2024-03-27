class Menu < ApplicationRecord
  belongs_to :restaurant

  validates :name, :description, presence: true
end
