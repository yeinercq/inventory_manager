class ExportsController < ApplicationController
  def index
    @exports = current_user.exports
  end

  def new
    @export = current_user.exports.build
  end

  def create
    @export = current_user.exports.build(export_params)
    if @export.save
      redirect_to exports_path, notice: t('exports.created_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def export_params
    params.require(:export).permit(:key, data_filters: [:start_date, :end_date])
  end

end
