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

      feed = @following_array << current_user.id
      @notes = Note.where(user_id: feed)
      @likes = Like.all
      
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

    followinglist = Relationship.where(follower_id: current_user.id)
    followinglist.each do |list|

      followingnotes = Note.where(user_id: list.following_id)
      followingnotes.each do |fn|
         
        Relationshipsnote.find_or_create_by(relationship_id: list.id, note_id: fn.id)

      end
    end
    redirect_to root_path
  end

  def unfollow
    unfollow = Relationship.where("follower_id = ? AND following_id = ?", "#{params[:follow]}", "#{params[:following]}").destroy_all
    redirect_to root_path
  end

  def like
    @note = params[:format]
    Like.find_or_create_by(user_id: current_user.id, note_id: @note)

    redirect_to root_path
  end

  def unlike
    @note = params[:format]
    @note = Like.where(user_id: current_user.id, note_id: @note)
    @note.destroy_all

    redirect_to root_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

end