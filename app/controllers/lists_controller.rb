class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    # @list = List.new
    @list = current_user.lists.new

    3.times do |i|
      @list.list_items.build(position: i + 1)
    end

    # @list_items = @list.list_items
    # (params[:items_count] || 3).to_i.times do |i|
    #   @list.list_items.build(position: i + 1)
    # end

    @categories = Category.all.pluck(:name, :id)
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = current_user.lists.new(list_params)
    # @list = List.new(list_params)

    if @list.save
      redirect_to @list, notice: "List was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @list = List.find(params[:id])

    if @list.update(list_params)
      redirect_to @list, notice: "List was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_url, notice: "List was successfully destroyed."
  end

  private

  def list_params
    params.require(:list).permit(
      :name,
      :description,
      :category_ids => [],
      list_items_attributes: [ :id, :name, :position, :_destroy ])
  end
end
