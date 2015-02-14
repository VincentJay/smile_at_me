class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find_by(name: params[:id])
    render 'show'
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
	if @user.save
	  sign_in @user
	  render 'users/signUp.js.erb'
	else
	  render 'users/signUpErrors.js.erb'
	end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
	if @user.update_attribute("avatar", params[:avatar])
	  render 'users/update.json.jbuilder'
	else 
		@user.update_attributes(user_params)
	end
  end
  
  def destroy
    User.find(params[:id]).destroy
	flash[:success] = "User destroyed"
	redirect_to users_url
  end
  
  
    
	private
    
    def user_params
      params.permit( :name, :avatar, :gender, :email, :password,
                                   :password_confirmation, :slug)	
    end
	
	
	def correct_user
	  @user = User.find(params[:id])
	  redirect_to(root_path) unless current_user?(@user)
	end
	
	def admin_user
	  redirect_to(root_path) unless current_user.admin?
	end

  end
