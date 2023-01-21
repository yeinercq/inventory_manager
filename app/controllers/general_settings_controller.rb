class GeneralSettingsController < ApplicationController
  before_action :set_general_setting, only: [ :edit, :update ]

  def new
    @general_setting = GeneralSetting.new
  end

  def create
    @general_setting = GeneralSetting.new(general_setting_params)
    @general_setting.company = current_company
    respond_to do |format|
      if @general_setting.save
        format.html { redirect_to wallets_path, notice: t('general_settings.created_success') }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @general_setting.update(general_setting_params)
      redirect_to wallets_path, notice: t('general_settings.updated_success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_general_setting
    @general_setting = current_company.general_setting
  end

  def general_setting_params
    params.require(:general_setting).permit(:sales_wallet_id, :coffee_wallet_id)
  end
end
