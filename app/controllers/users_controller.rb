class UsersController < ApplicationController
  before_filter :authenticate, :except => [:new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => [:destroy, :index]

  # GET /users
  # GET /users.xml  
  def index
    @users = User.paginate(:page => params[:page])
    @title = "User directory"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find_by_handle(params[:id])
    @title = @user.handle+"'s profile" 
    @notes = @user.notes.paginate(:page => params[:page])
    @nodes = @user.following 

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    if signed_in?
      redirect_to root_path
    else
      @user = User.new
      @title = "Sign up"
      @submit = "Sign Up"

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @user }
      end
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find_by_handle(params[:id])
    @title = "Edit "+@user.handle+"'s profile"
    @submit = "Update User"
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @submit = "Sign Up"

    respond_to do |format|
      if @user.save
        sign_in @user
        flash["alert-box success"] = "Welcome to Hackers R. Us!"
        format.html { redirect_to(root_path) }#, :notice => 'User was successfully updated.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        flash["alert-box"] = @user.errors.full_messages.first if @user.errors.any?
        format.html { render :action => "new" }
        #format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find_by_handle(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash["alert-box success"] = 'User was successfully updated.'
        format.html { redirect_to(@user) }#, :notice => "User was successfully updated") }
        format.xml  { head :ok }
      else
        flash["alert-box"] = @user.errors.full_messages.first if @user.errors.any?
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find_by_handle(params[:id])
    @user.destroy
    flash[:success] = "User Deleted."
    #redirect_to users_path

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  private

    #def authenticate
    #  deny_access unless signed_in?
    #end

    #def correct_user
    #  @user = User.find(params[:id])
    #  redirect_to(root_path) unless current_user?(@user)
    #end
    
    #def admin_user
    #  redirect_to(root_path) unless current_user.admin?
    #end
end
