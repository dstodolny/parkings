class SessionsController < ApplicationController
  def new
  end

  def create
    account = Account.find_by_email(params[:email])
    if account
      session[:account_id] = account.id
      redirect_to root_url, flash: { success: "You have been logged in." }
    else
      flash[:error] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:account_id] = nil
    redirect_to root_url, flash: { success: "Logged out." }
  end
end
