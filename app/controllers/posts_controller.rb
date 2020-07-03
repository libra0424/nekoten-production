# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show destroy]

  def new
    @post = Post.new
    @post.photos.build
    @cats = Cat.where(user: current_user)
  end

  def create
    @post = Post.new(post_params)
    @cats = Cat.where(user: current_user)
    if @post.save
      flash[:notice] = '投稿が保存されました'
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def index
    @followings = current_user.followings
    @posts = Post.where(user_id: @followings.ids).limit(10).includes(:photos, :user).order(created_at: :DESC)
  end

  def index_new
    @posts = Post.all.limit(10).order(created_at: :DESC)
  end

  def show; end

  def destroy
    if @post.user == current_user
      flash[:notice] = '投稿が削除されました' if @post.destroy
    else
      flash[:alert] = '投稿の削除に失敗しました'
    end
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:caption, { cat_ids: [] }, photos_attributes: [:image]).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
