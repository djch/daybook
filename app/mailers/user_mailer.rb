class UserMailer < ApplicationMailer

  def welcome_aboard(user)
    @user = user
    mail to: user.email, subject: "A few details about your Day Book account"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Day Book password reset"
  end
end
