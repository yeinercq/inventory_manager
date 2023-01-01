module SalesHelper
  def available_events_for(sale)
    sale.aasm.permitted_transitions.map { |t| t[:event] }
  end

  def show_balance_card(title, value)
    render partial: 'sales/balance_card', locals: {title: title, value: value}
  end
end
