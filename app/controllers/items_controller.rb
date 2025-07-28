class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy soft_delete restore]

  def index
    @items = Item.where(soft_deleted: false)
  end

  def trashed
    @items = Item.where(soft_deleted: true)
  end

  def show; end

  def new
    @item = Item.new
  end

  def edit; end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: "Item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to items_path, notice: "Item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # HARD delete
  def destroy
    @item.destroy
    redirect_back fallback_location: items_path, notice: "Item was permanently deleted."
  end

  # SOFT delete
  def soft_delete
    @item.update(soft_deleted: true)
    redirect_to items_path, notice: "Item was moved to trash."
  end

  def restore
    @item.update(soft_deleted: false)
    redirect_to trashed_items_path, notice: "Item was restored."
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description)
  end
end
