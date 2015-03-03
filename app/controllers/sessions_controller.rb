class SessionsController < ApplicationController
  def new

  end

  def create
    account = Account.find_by_email(params[:email])
    if account && account.authenticate(params[:password])
      session[:account_id] = account.id
      redirect_to root_url
    else
      render "new"
    end
  end
end
