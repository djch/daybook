module UsersHelper
  # Returns the gravatar image for a given user
  def gravatar_for(user, res: 160, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{res}"
    image_tag(gravatar_url, alt: user.name, class: "avatar", height: "#{size}", width: "#{size}")
  end
end
