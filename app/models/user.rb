# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :cats, dependent: :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  mount_uploader :profile_photo, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {
                      presence: true,
                      length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }}
  validates :name, presence: true, length: { maximum: 50 }
  with_options on: :create do
    validates :password, presence: true, length: { minimum: 6 }
  end
  with_options on: :update do
    validates :password, length: { minimum: 6 }, allow_blank: true
  end


  # パスワードなしでユーザーアカウント情報の変更を許可
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?  #パスワードが空なら
      params.delete(:password)                #paramsからパスワードを削除
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options) #paramsの情報をインスタンスにセット
    clean_up_passwords  #パスワードと確認パスワードの関係をnilに
    result
  end

  def self.guest
    find_or_create_by!(email: 'test@com') do |user|
      user.name = 'test user'
      user.email = 'test@test.com'
      user.password = Settings.test.password
      user.confirmed_at = Time.now
    end
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end

