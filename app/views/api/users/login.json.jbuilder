if @current_user.present?
  json.success true
  json.message "Successfully logged in"
  json.partial! 'users/details', current_user: @current_user, access_token: @access_token
else
  json.success false
  json.message "Invalid login or password"
end
