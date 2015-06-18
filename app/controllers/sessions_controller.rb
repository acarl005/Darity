class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(uid: auth["uid"], provider: auth["provider"]).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to user, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed out'
  end

  def login
    @user = User.where(email: user_params["email"]).first
    if @user && @user.authenticate(user_params["password"]) || !@user.password_digest
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Signed In'
    else
      @user = User.new(email: user_params["email"])
      flash[:error] = 'Invalid Info'
      render :"users/home"
    end
  end

  # def signup
  #   user = User.where(email: params[:session][:email]).first
  #   if user && user.authenticate(params[:session][:password])
  #     if user.activated?
  #       login user
  #       params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  #       redirect_to user
  #     else
  #       message = "Account not activated. Check your email for the activation link."
  #       flash[:warning] = message
  #       redirect_to root_url
  #     end
  #   else
  #     flash.now[:danger] = 'Invalid email/password combination'
  #     render 'new'
  #   end
  # end
end
