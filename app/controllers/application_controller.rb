class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_locale

  def set_locale
    I18n.locale = "es"
  end

  private

  def sales_wallet
    Wallet.find(current_company.general_setting.sales_wallet_id) unless current_company.general_setting.nil?
  end

  def coffee_wallet
    Wallet.find(current_company.general_setting.coffee_wallet_id) unless current_company.general_setting.nil?
  end

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end

  helper_method :current_company, :sales_wallet, :coffee_wallet
end
