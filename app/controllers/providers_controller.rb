class ProvidersController < ApplicationController
  before_action :set_provider, only: [:edit, :update, :destroy]

  def index
    # @providers = current_company.providers.ordered
    @providers = Provider.filter(filtering_params(params)).filter_by_company_id(current_company.id).ordered
  end

  def new
    @provider = current_company.providers.build
  end

  def create
    @provider = current_company.providers.build(provider_params)
    if @provider.save
      respond_to do |format|
        format.html { redirect_to providers_path, notice: t('providers.created_success') }
        format.turbo_stream { flash.now[:notice] = t('providers.created_success') }
      end
    else
    render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @provider.update(provider_params)
      respond_to do |format|
        format.html { redirect_to providers_path, notice: t('providers.updated_success') }
        format.turbo_stream { flash.now[:notice] = t('providers.updated_success') }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_path, notice: t('providers.destroyed_success') }
      format.turbo_stream { flash.now[:notice] = t('providers.destroyed_success') }
    end
  end

  private

  def filtering_params(params)
    params.slice(:name)
  end

  def set_provider
    @provider = current_company.providers.find(params[:id])
  end

  def provider_params
    params.require(:provider).permit(:name, :email, :phone_number)
  end
end
