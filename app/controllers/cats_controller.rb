# frozen_string_literal: true

class CatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cat, only: %i[show destroy edit update]

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      flash[:notice] = 'ウチの子に追加されました'
      redirect_to cats_path
    else
      flash.now[:alert] = '追加に失敗しました'
      render :new
    end
  end

  def index
    @cats = Cat.where(user_id: current_user.id)
  end

  def show
    @gender = cat_gender(@cat.gender)
    @posts = @cat.posts
  end

  def destroy
    if @cat.user == current_user
      flash[:notice] = 'ウチの子から削除されました' if @cat.destroy
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to cats_path
  end

  def edit
  end

  def update
    if @cat.user == current_user
      @cat.update(cat_params)
      flash[:notice] = 'ウチの子の情報を変更しました'
      redirect_to cat_url(@cat)
    else
      render 'edit'
      flash[:alert] = '更新に失敗しました'
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :gender, :birthday, :coatcolor, :cat_species, :profile_photo).merge(user_id: current_user.id)
  end

  def set_cat
    @cat = Cat.find_by(id: params[:id])
  end

  def cat_gender(gender)
    if gender == 0
      '男の子'
    else
      '女の子'
    end
  end
end
