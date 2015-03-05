class AccountsController < ApplicationController
  def new
    @account = Account.new
    @account.build_person
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      UserMailer.welcome_email(@account).deliver_later
      session[:account_id] = @account.id
      format.html { redirect_to(root_url, flash: { success: "Account has been successfully created." }) }
    else
      format.html { render action: "new" }
    end
  end

  private

  def account_params
    params.require(:account).permit(:email, :password, :password_confirmation,
                                    person_attributes: [:first_name, :last_name])
  end
end
