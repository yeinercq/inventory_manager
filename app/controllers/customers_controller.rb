class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = current_company.customers.all
  end

  def show
  end

  def new
    @customer = current_company.customers.build
  end

  def create
    @customer = current_company.customers.build(customer_params)
    if @customer.save
      redirect_to customers_path, notice: "Customer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_path, notice: "Customer was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: "Customer was successfully destroyed."
  end

  private

  def set_customer
    @customer = current_company.customers.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :phone_number, :id_number, :address)
  end
end
