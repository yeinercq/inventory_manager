module SalesHelper
  def available_events_for(invoice)
    invoice.aasm.permitted_transitions.map { |t| t[:event] }
  end
end
