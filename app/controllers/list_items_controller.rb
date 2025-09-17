class ListItemsController < ApplicationController
  def index
    @list_items = ListItem.all
  end

  def show
    @list_item = ListItem.find(params[:id])
  end
end
