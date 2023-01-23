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
    @transaction = current_user.transactions.build(transaction_params)
    @transaction.wallet_id = @wallet.id
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to wallet_path(@wallet), notice: t('transactions.created_success') }
      else
        format.html { render @transaction.transaction_type.to_sym, status: :unprocessable_entity }
        format.turbo_stream { render "#{@transaction.transaction_type}_form_update", status: :unprocessable_entity }
      end
    end
  end

  private

  def set_wallet
    @wallet = current_company.wallets.find(params[:wallet_id])
  end

  def transaction_params
    params.require(:transaction).permit(:transaction_type, :amount, options: [:target_wallet, :from_wallet, :sale_id])
  end
end
