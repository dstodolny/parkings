class SessionsController < ApplicationController
  def new
  end

  def create
    account = FacebookAccount.find_or_create_for_facebook(request.env["omniauth.auth"]) || Account.authenticate(params[:email], params[:password])
    if account
      session[:account_id] = account.id
      session[:account_type] = account.model_name.name
      redirect_to (session[:return_to] || root_url), flash: { success: "You have been logged in." }
    else
      flash[:error] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:account_id] = nil
    session[:account_type] = nil
    reset_session
    redirect_to root_url, flash: { success: "Logged out." }
  end
end
