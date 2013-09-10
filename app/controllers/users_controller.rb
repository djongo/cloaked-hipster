class UsersController < ApplicationController
	before_filter :authenticate_user!

  def index
    @per_page = params[:per_page] || 15
    @users = User.paginate( :per_page => @per_page, :page => params[:page] )
  end

  def show
    @user = User.find(params[:id])  	
  end
end
