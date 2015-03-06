class UserMailer < ApplicationMailer

  def welcome_email(account)
    @account = account
    @url = "http://bootcamp-dstodolny.herokuapp.com/login"
    mail(to: @account.email, subject: "Welcome to Bookparking")
  end
end
