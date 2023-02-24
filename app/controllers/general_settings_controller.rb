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
    respond_to do |format|
      if @general_setting.update(general_setting_params)
        format.html { redirect_to wallets_path, notice: t('general_settings.updated_success') }
      else
        format.html {render :edit, status: :unprocessable_entity}
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_general_setting
    @general_setting = current_company.general_setting
  end

  def general_setting_params
    params.require(:general_setting).permit(
      :base_seco_coffee_price,
      :base_verde_coffee_price,
      :base_pasilla_coffee_price,
      :sample_seco_weight_quantity,
      :sample_verde_weight_quantity,
      :sample_pasilla_weight_quantity,
      :destare_quantity
    )
  end
end
