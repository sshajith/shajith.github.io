class UsersController < ApplicationController

	def create
    
    respond_to do |format|
      unless params[:enable_company].present?
        params[:user].delete :company_attributes
      end
      @user = User.new(params[:user])
      if @user.save
        @user.confirm!
        sign_in(@user, :bypass => true)
        if @user.company.nil?
          format.html { redirect_to root_url }
        else
          format.html { redirect_to uname_url(current_user.company.uname) }
        end
        format.json { render json: @user, status: :created, location: @user }
      else
        Rails.logger.info(@user.errors.inspect)
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end