require "uri"
require "net/http"
require "cgi"
class PostJob
  include SuckerPunch::Job
  workers 8

  def perform(post_id)
    @post = Post.find(post_id)
    ActiveRecord::Base.connection_pool.with_connection do
      if (@post.scheduled_on - @post.created_at).to_i > 0
        seconds = (@post.scheduled_on - Time.now).to_i.abs
        puts '#seconds'
        puts seconds.to_i
        @post.update_attributes(:state => 'sleep for'+seconds.to_s+' seconds')
        sleep seconds.to_i
      else
        @post.update_attributes(:state => 'no sleep')
      end

      puts '#process done'
      @post.get_account_ids.each do |account|
        account = Account.find(account)
        if account.provider == 'Facebook'
          @graph = Koala::Facebook::API.new(account.access_token)
          profile = @graph.get_object("me")
          @graph.put_connections("me", "feed", :message => @post.title)
          @post.update_attributes(:state => @post.state+'\nFacebook_post_time:'+ Time.now.to_s)

        elsif account.provider == 'Twitter'
          client = Twitter::REST::Client.new do |config|
            config.consumer_key        = ENV['TWITTER_KEY']
            config.consumer_secret     = ENV['TWITTER_SECRET']
            config.access_token        = account.access_token
            config.access_token_secret = account.access_token_secret
          end

          client.update(@post.title)
          @post.update_attributes(:state => @post.state+'\nTwitter_post_time:'+ Time.now.to_s)
        end

      end
    end
  end
end