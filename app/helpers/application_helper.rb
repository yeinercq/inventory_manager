module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/messages"
  end

  def form_error_notification(object)
    if object.errors.any?
      tag.div class: "error-message alert alert-primary" do
        object.errors.full_messages.to_sentence.capitalize
      end
    end
  end

  def  formated_currency(number)
    number_to_currency(number, unit: "$", format: "%u %n")
  end
end
