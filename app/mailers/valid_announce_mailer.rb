class ValidAnnounceMailer < ApplicationMailer
  def valid_announce_mail(current_user)
    @user = current_user
      mail to: @user.email,
      subject: t('.valid announcement')
  end
end
