class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!, unless: :devise_controller?

  def set_locale
    I18n.locale = "es"
  end

  private

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end

  helper_method :current_company
end
