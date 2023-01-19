class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show, :edit, :update]

  def index
    @wallets = current_company.wallets.all
  end

  def show
    @transactions = @wallet.transactions.limit(10)
  end

  def new
    @wallet = current_company.wallets.build
  end

  def create
    @wallet = current_company.wallets.build(wallet_params)
    @wallet.amount = 0.0
    if @wallet.save
      redirect_to wallets_path, notice: t('wallets.created_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @wallet.update(wallet_params)
      redirect_to wallets_path, notice: t('wallets.created_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_wallet
    @wallet = current_company.wallets.find(params[:id])
  end

  def wallet_params
    params.require(:wallet).permit(:name)
  end
end
