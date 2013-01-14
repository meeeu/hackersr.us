class NotesController < ApplicationController
  before_filter :authenticate, :only => :create
  before_filter :correct_note_user, :only => [:edit, :update]
  #before_filter :admin_user,        :only => :destroy
  before_filter :is_admin?,     :only => :destroy

  def create
    @note = current_user.notes.new(params[:note]) 
    
    if @note.save
      flash["alert-box success"] = "Note passed!"
      redirect_back_or root_path
    else
      flash["alert-box"] =  @note.errors.full_messages.first if @note.errors.any?
      redirect_back_or root_path
    end
  end

  def edit
    @note = Note.find(params[:id])
    @title = "Edit "+@note.title
  end

  def update
    @note = Note.find(params[:id])

    if @note.update_attributes(params[:note])
      flash["alert-box success"] = "Note Updated!"
      redirect_to(node_path(Node.find(params[:id] = @note.node_id).name))
    else
      flash["alert-box"] =  @note.errors.full_messages.first if @note.errors.any?
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_back_or root_path
  end

  private
    def correct_note_user
      @note = Note.find(params[:id])
      @user = User.find(@note.user_id)
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def is_admin?
      if current_user.admin?
        return admin_user
      else
        return correct_note_user
      end
    end
end
