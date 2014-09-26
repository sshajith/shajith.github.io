class Account < ActiveRecord::Base
  belongs_to :user

  validates_presence_of  :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  #attr_accessible :access_token, :dob, :email, :gender, :image, :name, :provider, :state, :uid, :username
end
