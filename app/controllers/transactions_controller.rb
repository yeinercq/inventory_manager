class TransactionsController < ApplicationController
  before_action :set_wallet

  def deposit
    @transaction = current_user.transactions.build
  end

  def withdraw
    @transaction = current_user.transactions.build
  end

  def transfer
    @transaction = current_user.transactions.build
  end

  def create
    @from_method = params[:transaction_type]
    @transaction = current_user.transactions.build(transaction_params)
    @transaction.wallet_id = @wallet.id
    if @transaction.save
      redirect_to wallet_path(@wallet), notice: t('transactions.created_success')
    else
      render @transaction.transaction_type.to_sym, status: :unprocessable_entity
    end
  end

  private

  def set_wallet
    @wallet = current_company.wallets.find(params[:wallet_id])
  end

  def transaction_params
    params.require(:transaction).permit(:transaction_type, :amount, options: [:target_wallet])
  end
end
