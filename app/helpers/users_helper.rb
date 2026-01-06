module UsersHelper
  def current_user_avatar
    if current_user.avatar.attached?
      image_tag current_user.avatar.variant(resize_to_limit: [150, 150]),
                class: 'rounded-full shadow-md'
    else
      image_tag 'default_avatar.png', class: 'rounded-full'
    end
  end
end
