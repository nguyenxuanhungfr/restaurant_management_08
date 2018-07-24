class UserMailer < ApplicationMailer

  def user_mail user, order
    @user = user
    @booking = order
    mail to: user.email, subject: t("home.info_order")
  end
end
