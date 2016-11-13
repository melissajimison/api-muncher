class User < ActiveRecord::Base
  validates :email, :uid, :provider, presence: true

  has_many :myrecipes

  def self.build_from_google(auth_hash)

    # find or create a user based on the information in the auth_hash
    user = User.find_or_initialize_by(uid: auth_hash[:uid], provider: 'google')
    user.uid   = auth_hash[:uid]
    user.provider = 'google'
    user.name  = auth_hash['info']['name']
    user.email = auth_hash['info']['email']

    user.save

    return user
  end
end
