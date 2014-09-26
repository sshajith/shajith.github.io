class Post < ActiveRecord::Base
  belongs_to :user
  #attr_accessible :account_ids, :category, :scheduled_on, :state, :title, :url

  serialize :account_ids, Array
  
  def get_account_ids
    account_ids.map { |q| q }
  end

  def get_accounts
    Account.find(self.account_ids)
  end
end
