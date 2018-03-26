class NoteMailer < ApplicationMailer

  def like_email(user)
    @user = User.find(user)
    mail(to: @user.email, subject: 'Somebody like your note :)')
  end

  def dislike_email(user)
    @user = User.find(user)
    mail(to: @user.email, subject: 'Somebody dislike your note :(')
  end

end