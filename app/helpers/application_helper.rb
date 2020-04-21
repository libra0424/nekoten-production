# frozen_string_literal: true

module ApplicationHelper
  def avatar_url(user)
    return user.profile_photo unless user.profile_photo.nil?
    gravatar_id = Digest::MD5.hexdigest(user.email).downcase
    "https://www.gravatar.com/avatar/#{gravatar_id}.jpg"
  end

  def user_profile_photo(user)
    if user.profile_photo?
      user.profile_photo.thumb.url
    else
      "user_default.jpg"
    end
  end
end
