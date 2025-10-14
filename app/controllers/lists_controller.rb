class ListsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_list, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = current_user.lists.new
    (params[:items_count] || 3).to_i.times do |i|
      @list.list_items.build(position: i + 1)
    end

    @categories = Category.all.pluck(:name, :id)
  end

  def edit
  end

  def mylists
    @lists = current_user.lists
    @is_mylists = true
    render :index
  end

  def create
    @list = current_user.lists.new(list_params)

    if @list.save
      redirect_to @list, notice: "List was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      redirect_to @list, notice: "List was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_url, notice: "List was successfully deleted."
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def authorize_user!
    return if @list.user == current_user
      redirect_to lists_path, alert: "You are not authorized to perform this action."
  end

  def list_params
    params.require(:list).permit(
      :name,
      :description,
      category_ids: [],
      list_items_attributes: [ :id, :name, :position, :_destroy ])
  end
end
