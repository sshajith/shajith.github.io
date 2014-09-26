class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @account = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    @account.update_attributes(:user_id => current_user.id)

    if @account.persisted?
      puts 'testing1'
      redirect_to root_path, notice: "Facebook account added successfully"
      # sign_in_and_redirect @user, notice: "singed in successfully"
    else
      puts 'testing2'
      Rails.logger.info(@user.errors.inspect)
      redirect_to '/', notice: 'Something went wrong. please try again.'
    end

  end

  def twitter
    @account = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)
    @account.update_attributes(:user_id => current_user.id)

    if @account.persisted?
      puts 'testing1'
      redirect_to root_path, notice: "Facebook account added successfully"
      # sign_in_and_redirect @user, notice: "singed in successfully"
    else
      puts 'testing2'
      Rails.logger.info(@user.errors.inspect)
      redirect_to '/', notice: 'Something went wrong. please try again.'
    end
  end

end