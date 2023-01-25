module CoffeePurchasesHelper
  def available_events_for(coffee_purchase)
    coffee_purchase.aasm.permitted_transitions.map { |t| t[:event] }
  end
end
