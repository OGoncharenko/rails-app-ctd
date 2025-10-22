class List < ApplicationRecord
  belongs_to :user
  has_many :list_items, inverse_of: :list, dependent: :destroy
  has_many :list_categories, dependent: :destroy
  has_many :categories, through: :list_categories

  accepts_nested_attributes_for :list_items, allow_destroy: true
  accepts_nested_attributes_for :list_categories, allow_destroy: true

  validates :name, presence: true, length: { maximum: 60 }
  validates :description, length: { maximum: 10000 }
  validate :empty_any_list_items
  validate :max_list_categories

  private

  def empty_any_list_items
    if list_items.any? { |item| item.name.blank? }
      errors.add(:base, "List items cannot be empty.")
    end
  end

  def max_list_categories
    if list_categories.size > 2
      errors.add(:categories, "Can't have more than 2 categories")
    end
  end
end
