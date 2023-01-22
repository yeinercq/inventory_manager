module WalletsHelper
  def has_two_wallets?
    current_company.wallets.count == 2
  end
end
