# frozen_string_literal: true

module FlashHelper
  ALERT_TYPES = %i[danger info success warning error].freeze unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if %i[alert error].include?(type)
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(
          :div,
          content_tag(:button, raw('&times;'), :class => 'close', 'data-dismiss' => 'alert') +
          msg.html_safe, class: "alert alert-#{type}"
        )
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end
end
