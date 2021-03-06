class UsersController < ApplicationController
	before_filter :authenticate_user!
  filter_resource_access

  def index
    # @per_page = params[:per_page] || 15
    @users = User.order(:name)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end    
  end

  def show
    #@user = User.find(params[:id])
  end

  def new
    #@user = User.new
  end
  
  def create
    #@user = User.new(params[:user])
    if @user.save
      redirect_to root_url, notice: "Registration successful."
    else
      render :action => 'new'
    end
  end
  def edit
      #@user = User.find(params[:id])
#    if @user.roles.include?("publication_group")
#      @user = User.find(params[:id])
#    else
#      @user = current_user
#    end
  end
  
  def update
      #@user = User.find(params[:id])
    if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
    end
      
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      #Notifier.test_mail(@user)
      if(current_user.roles.include?("publication_group"))
        redirect_to users_url
       else
        redirect_to root_url
       end
     else
      render :action => 'edit'
    end
  end  

  def destroy
    #@user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: "User removed."
  end
end
