module UserHelpers
  def gravatar(email)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}.jpg"
  end
end
