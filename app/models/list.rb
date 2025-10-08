class List < ApplicationRecord
  belongs_to :user
  has_many :list_items, inverse_of: :list, dependent: :destroy
  has_many :list_categories, dependent: :destroy
  has_many :categories, through: :list_categories

  accepts_nested_attributes_for :list_items, allow_destroy: true

  validate :maximum_two_categories
  validates :name, presence: true, length: { maximum: 60 }
  validates :description, length: { maximum: 10000 }
  validate :first_three_items_not_empty

  private
  def maximum_two_categories
    if category_ids.size > 2
      errors.add(:categories, "Can't have more than 2 categories")
    end
  end

  def first_three_items_not_empty
    first_three = list_items.first(3)

    if first_three.all? { |item| item.name.blank? }
      errors.add(:base, "The first three list items cannot all be empty.")
    end
  end
end
