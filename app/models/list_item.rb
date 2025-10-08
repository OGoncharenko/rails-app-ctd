class ListItem < ApplicationRecord
  belongs_to :list

  before_create :set_position
  after_destroy :normalize_positions

  private
  def set_position
    if self.position.nil?
      self.position = (list.list_items.maximum(:position) || 0) + 1
    end
  end

  def normalize_positions
    list.list_items.order(:position).each.with_index(1) do |item, index|
      item.update_column(:position, index)
    end
  end
end
