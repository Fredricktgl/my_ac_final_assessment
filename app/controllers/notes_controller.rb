class NotesController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    @users = User.all
    @notes = Note.all
    
    if current_user
      @following_array = []
      @following = Relationship.where(follower_id: current_user.id)
      @following.each do |following|
        @following_array << following.following_id
      end

      @notes = Note.where(user_id: current_user)
      
    end
    
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
     redirect_to root_path
    else
     render :new
    end
  end

  def show
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    @note.update(note_params)
    redirect_to root_path
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    @note.destroy
    redirect_to root_path
  end

  def follow
    follow = Relationship.new(follower_id: params[:follow], following_id: params[:following])
    follow.save
    redirect_to root_path
  end

  def unfollow
    unfollow = Relationship.where("follower_id = ? AND following_id = ?", "#{params[:follow]}", "#{params[:following]}").destroy_all
    redirect_to root_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

end