class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @lists = @category.lists
    @page_title = "#{@category.name}"
    render "lists/index"
  end
end
