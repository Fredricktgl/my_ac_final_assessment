class NotesController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
    @notes = Note.all
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

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end

end