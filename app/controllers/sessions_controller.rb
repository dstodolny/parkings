class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth
      facebook_account = FacebookAccount.find_or_create_for_facebook(auth)
      session[:account_id] = facebook_account.id
      session[:account_type] = "facebook"
      redirect_to (session[:return_to] || root_url), flash: { success: "You have been logged in." }
    else
      account = Account.authenticate(params[:email], params[:password])
      if account
        session[:account_id] = account.id
        session[:account_type] = "email"
        redirect_to (session[:return_to] || root_url), flash: { success: "You have been logged in." }
      else
        flash[:error] = "Email or password is invalid"
        render "new"
      end
    end
  end

  def destroy
    session[:account_id] = nil
    reset_session
    redirect_to root_url, flash: { success: "Logged out." }
  end
end
