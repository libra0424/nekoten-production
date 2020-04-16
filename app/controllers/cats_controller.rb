class CatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cat, only: %i(show destroy)

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cats_path
      flash[:notice] = "ウチの子に追加されました"
    else
      redirect_to new_cat_path
      flash[:alert] = "追加に失敗しました"
    end
  end

  def index
    @cats = Cat.all
  end
  
  def show
  end

  def destroy
    if @cat.user == current_user
      flash[:notice] = "ウチの子から削除されました" if @cat.destroy
    else
      flash[:alert] = "削除に失敗しました"
    end
    redirect_to cats_path
  end

  private
    def cat_params
      params.require(:cat).permit(:name,:gender,:birthday,:coatcolor,:cat_species).merge(user_id: current_user.id)
    end

    def set_cat
      @cat = Cat.find_by(id: params[:id])
    end

end
