class CoffeePurchasesController < ApplicationController
  before_action :set_coffee_purchase, only: [:show, :edit, :update, :destroy]
  def index
    @coffee_purchases = current_company.coffee_purchases.limit(10).ordered
  end

  def show
  end

  def new
    @coffee_purchase = current_user.coffee_purchases.build
  end

  def create
    @coffee_purchase = current_user.coffee_purchases.build(coffee_purchase_params)
    @coffee_purchase.destare_quantity = current_company.general_setting.destare_quantity
    if @coffee_purchase.save
      redirect_to coffee_purchases_path, notice: "Coffee purchase sucessfuly created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @coffee_purchase.update(coffee_purchase_params)
      redirect_to coffee_purchases_path, notice: "Coffee purchase sucessfuly updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @coffee_purchase.destroy
      redirect_to coffee_purchases_path, notice: "Coffee purchase sucessfuly destroyed."
    end
  end

  private

  def set_coffee_purchase
    @coffee_purchase = current_company.coffee_purchases.find(params[:id])
  end

  def coffee_purchase_params
    params.require(:coffee_purchase).permit(
      :client_id,
      :coffee_type,
      :quantity,
      :packs_count,
      :decrease_quantity,
      :sieve_quantity,
      :healthy_almond_quantity,
      :pasilla_quantity
    )
  end
end
