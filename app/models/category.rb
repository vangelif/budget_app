class Category < ApplicationRecord
  has_one_attached :icon

  belongs_to :user
  has_and_belongs_to_many :expenses

  validates :name, presence: true, uniqueness: true

end
