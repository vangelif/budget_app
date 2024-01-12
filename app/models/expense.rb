class Expense < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_and_belongs_to_many :categories

  validates :name, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :user, presence: true
end
