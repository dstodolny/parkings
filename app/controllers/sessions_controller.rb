class SessionsController < ApplicationController
  def new
  end

  def create
    sign_in_with_oauth || sign_in_with_email
  end

  def destroy
    session[:account_id] = nil
    session[:account_type] = nil
    reset_session
    redirect_to root_url, flash: { success: "Logged out." }
  end

  private

  def sign_in_with_oauth
    return false unless request.env["omniauth.auth"]
    facebook_account = FacebookAccount.find_or_create_for_facebook(request.env["omniauth.auth"])
    session[:account_id] = facebook_account.id
    session[:account_type] = "facebook"
    flash[:success] = "You have been logged in."
    redirect_to(session[:return_to] || root_url)
  end

  def sign_in_with_email
    account = Account.authenticate(params[:email], params[:password])
    if account
      session[:account_id] = account.id
      flash[:success] = "You have been logged in."
      redirect_to(session[:return_to] || root_url)
    else
      flash[:error] = "Email or password is invalid"
      render "new"
    end
  end
end
