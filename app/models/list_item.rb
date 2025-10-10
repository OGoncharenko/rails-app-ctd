class ListItem < ApplicationRecord
  belongs_to :list

  before_create :set_position


  private
  def set_position
    if self.position.nil?
      self.position = (list.list_items.maximum(:position) || 0) + 1
    end
  end
end
