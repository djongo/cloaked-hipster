class UsersController < ApplicationController
	before_filter :authenticate_user!

  def index
    # @per_page = params[:per_page] || 15
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end    
  end

  def show
    @user = User.find(params[:id])  	
  end
end
