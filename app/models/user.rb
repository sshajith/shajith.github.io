class User < ActiveRecord::Base

  #acts_as_tenant(:account)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  belongs_to :account

  has_one :company
  has_many :posts
  has_many :accounts

  accepts_nested_attributes_for :company, :allow_destroy => true

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    account = Account.where(:email => auth.info.email).first
    if !account
      #user = User.create(name:auth.extra.raw_info.name,
                      #   uid:auth.uid,
                      #   username: auth.extra.raw_info.username,
                      #   gender: auth.extra.raw_info.gender,
                      #   image: auth.info.image,
                      #   email:auth.info.email,
                      #   access_token: auth.credentials.token,
                      #   password:Devise.friendly_token[0,20]

                      # )
      account = Account.create(name:auth.extra.raw_info.name,
                        uid:auth.uid,
                        username: auth.extra.raw_info.username,
                        gender: auth.extra.raw_info.gender,
                        image: auth.info.image,
                        email:auth.info.email,
                        access_token: auth.credentials.token,
                        provider: 'Facebook'

                      )
      # user.confirm!
    elsif account.access_token != auth.credentials.token
      account.update_attributes(:access_token => auth.credentials.token, :uid => auth.uid)
      # user.confirm!
    end
    account
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    account = Account.where(:email => auth.info.email).first
    if !account
      #user = User.create(name:auth.extra.raw_info.name,
                      #   uid:auth.uid,
                      #   username: auth.extra.raw_info.username,
                      #   gender: auth.extra.raw_info.gender,
                      #   image: auth.info.image,
                      #   email:auth.info.email,
                      #   access_token: auth.credentials.token,
                      #   password:Devise.friendly_token[0,20]

                      # )
      account = Account.create(name:auth.extra.raw_info.name,
                        uid:auth.uid,
                        username: auth.extra.raw_info.username,
                        gender: auth.extra.raw_info.gender,
                        image: auth.info.image,
                        email:auth.info.email,
                        access_token: auth.credentials.token,
                        access_token_secret: auth.credentials.secret,
                        provider: 'Twitter'

                      )
      # user.confirm!
    elsif account.access_token != auth.credentials.token
      account.update_attributes(:access_token => auth.credentials.token, :uid => auth.uid)
      # user.confirm!
    end
    account
  end
end
