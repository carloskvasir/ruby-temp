module UsersBackofficeHelper
  def get_avatar_url
    avatar = current_user.user_profile.avatar
    avatar.attached? ? avatar : 'https://images.pexels.com/photos/268349/pexels-photo-268349.jpeg'
  end
end
