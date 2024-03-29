class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:handle],
                             params[:session][:password])
    if user.nil?
      flash.now["alert-box"] = "Invalid handle/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or root_path
    end
  end

  def destroy
    sign_out
    clear_return_to
    redirect_to root_path
  end
end
