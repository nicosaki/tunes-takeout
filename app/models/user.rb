class User < ActiveRecord::Base
  validates :name, :id, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    user = User.find_by(uid: auth_hash["uid"] ||=auth_hash["info"]["id"], provider: auth_hash["provider"])
    if user.nil?
      user = User.new(uid: auth_hash["uid"] ||=auth_hash["info"]["id"], provider: auth_hash["provider"], name: auth_hash["info"]["display_name"])
      if user.save!
        return user
      else
        return nil
      end
    end
    return user
  end

end
