class Category < ApplicationRecord
  has_many :list_categories, dependent: :destroy
  has_many :lists, through: :list_categories

  validates :name, presence: true, uniqueness: true
end
