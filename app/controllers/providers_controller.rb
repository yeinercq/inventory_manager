class ProvidersController < ApplicationController
  before_action :set_provider, only: [:edit, :update, :destroy]

  def index
    @providers = current_company.providers.all
  end

  def new
    @provider = current_company.providers.build
  end

  def create
    @provider = current_company.providers.build(provider_params)
    if @provider.save
      respond_to do |format|
        format.html { redirect_to providers_path, notice: "Provider was successfully created." }
      end
    else
    render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @provider.update(provider_params)
      redirect_to providers_path, notice: "Provider was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @provider.destroy
    redirect_to providers_path, notice: "Provider was successfully destroyed."
  end

  private

  def set_provider
    @provider = current_company.providers.find(params[:id])
  end

  def provider_params
    params.require(:provider).permit(:name, :email, :phone_number)
  end
end
