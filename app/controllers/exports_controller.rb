class ExportsController < ApplicationController
  def index
    @exports = current_user.exports
  end

  def new
    @export = current_user.exports.build
  end

  def create
    @export = current_user.exports.build(export_params)
    respond_to do |format|
      if @export.save
        format.html { redirect_to exports_path, notice: t('exports.created_success') }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  private

  def export_params
    params.require(:export).permit(:key, data_filters: [:start_date, :end_date])
  end

end
