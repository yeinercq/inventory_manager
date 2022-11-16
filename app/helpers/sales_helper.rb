module SalesHelper
  def available_events_for(sale)
    sale.aasm.permitted_transitions.map { |t| t[:event] }
  end
end
