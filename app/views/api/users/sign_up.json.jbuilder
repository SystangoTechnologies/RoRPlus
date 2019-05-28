if @current_user.errors.blank?
  json.success true
  json.message 'Signed up successfully.'
  json.partial! 'users/details', current_user: @current_user
else
  json.success false
  json.message @current_user.errors.full_messages.uniq.join(",")
end
