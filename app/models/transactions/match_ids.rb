class Transactions::MatchIds < ActiveModel::Validator
  def validate(record)
    other_wallet = Wallet.find(record.options["target_wallet"])
    if Base64.encode64("#{record.user.company_id}-#{record.options["target_wallet"]}") != other_wallet.code
      record.errors.add :base, "Ids don't match"
    end
  end
end
