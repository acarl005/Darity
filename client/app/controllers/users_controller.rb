class UsersController < ApplicationController

  def show
    find_user
    retreive_all_dares
  end

  def home
    @user = User.new
  end

  def index
    @pending_dare = PendingDare.new
    if params[:phrase]
      @users = User.where("username LIKE ?", "%#{params[:phrase]}%")
      render json: @users
    else
      @users = User.all
    end
  end

  def login
    @user = User.where(email: user_params["email"]).first
    if @user && @user.password == user_params["password"]
      session[:user_id] = @user.id
      redirect_to @user
    end
  end

  def create
  end

  def invite
    @pending_dare = PendingDare.new(pend_params)
    @pending_dare.proposer = current_user
    if @pending_dare.save
      redirect_to @pending_dare
    else
      p 'fail'
    end
  end

  private

  def retreive_all_dares
    @challenged_dares = @user.challenged_dares
    @proposed_dares = @user.proposed_dares
    @pledged_dares = @user.pledged_dares
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def pend_params
    params.require(:pending_dare).permit(:title, :description, :twitter_handle)
  end

  def find_user
    begin
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @user = User.new
      render html: "<h1>User No Found</h1>"
    end
  end

end
