class ItemsController < ApplicationController

  before_action :require_login, except: [:index, :show]

  load_resource
  authorize_resource except: [:index, :show]

  def index
    if params[:tag]
      @items = Item.tagged_with(params[:tag]).search(params[:term])
    else
      @items = Item.search(params[:term])
    end
    respond_to do |format|
      format.html
      format.json{ render json: @items }
    end
  end

  def show
  end

  def new
  end

  def create
    @item.user_id = current_user.id
    if @item.save
      redirect_to @item
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @item.update_attributes(item_params)
      redirect_to @item
    else
      render "edit"
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url
  end

  def item_params
    params.require(:item).permit(:name, :description, :user_id, :item_image,
                                 :tag_list, :address, :latitude, :longitude)
  end

end
