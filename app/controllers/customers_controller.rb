class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    # @customers = current_company.customers.ordered
    # @customers = current_company.customers.where("id_number LIKE ?", "%#{params[:search]}%")

    # if params[:id_number].present?
    #   @customers = current_company.customers.filter_by_id_number(params[:id_number])
    # else
    #   @customers = current_company.customers.ordered
    # end

    # .filter() receives keys->values to filter sale index
    @customers = Customer.filter(filtering_params(params)).filter_by_company_id(current_company.id).ordered
  end

  def show
  end

  def new
    @customer = current_company.customers.build
  end

  def create
    @customer = current_company.customers.build(customer_params)
    if @customer.save
      respond_to do |format|
        format.html { redirect_to customers_path, notice: t('customers.created_success') }
        format.turbo_stream { flash.now[:notice] = t('customers.created_success') }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      respond_to do |format|
        format.html { redirect_to customers_path, notice: t('customers.updated_success') }
        format.turbo_stream { flash.now[:notice] = t('customers.updated_success') }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_path, notice: t('customers.destroyed_success') }
      format.turbo_stream { flash.now[:notice] = t('customers.destroyed_success') }
    end
  end

  private
  # A list of the param names that can be used for filtering the Product list
  def filtering_params(params)
    params.slice(:id_number)
  end

  def set_customer
    @customer = current_company.customers.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :phone_number, :id_number, :address)
  end
end
