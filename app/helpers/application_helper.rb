module ApplicationHelper
  def page_title
    [params[:controller].humanize, 'Bootcamp App'].compact.join(" - ")
  end
end
