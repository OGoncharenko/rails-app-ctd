class Category < ApplicationRecord
  has_many :list_categories, dependent: :destroy
  has_many :lists, through: :list_categories
end
