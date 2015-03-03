class SessionsController < ApplicationController
  def new
  end

  def create
    account = Account.authenticate(params[:email], params[:password])
    if account
      session[:account_id] = account.id
      redirect_to (session[:return_to] || root_url), flash: { success: "You have been logged in." }
    else
      flash[:error] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:account_id] = nil
    reset_session
    redirect_to root_url, flash: { success: "Logged out." }
  end
end
