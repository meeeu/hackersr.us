module SessionsHelper
  def current_user=(user) 
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    store_location
    flash["alert-box"] = "You need to sign in first."
    redirect_to signin_path#, :notice => "You need to sign in first."
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  private
    def correct_note_user
      @note = Note.find(params[:id])
      @user = User.find(@note.user_id)
      redirect_to(root_path) unless current_user?(@user)
    end

    def correct_user
      @user = User.find_by_handle(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end
end
