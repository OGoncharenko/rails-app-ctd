class ListItemsController < ApplicationController
  def index
    @list_items = ListItem.all
  end

  def show
    @list_item = ListItem.find(params[:id])
  end

  def new
    @list_item = ListItem.new
  end

  def create
    ListItem.create!(list_item_params.merge(list: list))
  end

  def edit
    @list_item = ListItem.find(params[:id])
  end

  def update
    @list_item.update!(list_item_params)
  end

  def destroy
    @list_item = ListItem.find(params[:id])
    @list_item.destroy!
  end

  def list_item_params
    params.require(:list_item).permit(:name, :position)
  end
end
