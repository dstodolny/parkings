class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_person

  before_action :set_locale

  def set_locale
    session[:locale] = params[:locale] if params[:locale]

    I18n.locale = session[:locale] || locale_from_header || I18n.default_locale
  end

  private

  def current_person
    if session[:account_id]
      if session[:account_type] == "facebook"
        @current_person ||= FacebookAccount.find(session[:account_id]).person
      else
        @current_person ||= Account.find(session[:account_id]).person
      end
    end
 end

  def authorize
    redirect_to new_session_path, flash: { error: "Not authorized" } if current_person.nil?
  end

  def locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE'].try(:scan, /^[a-z]{2}/).try(:first)
  end
end
