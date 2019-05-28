# frozen_string_literal: true

module ApplicationHelper
  def show_error(object, attribute_name)
    object.errors.full_messages_for(attribute_name).join(',') if object.errors.any?
  end
end
