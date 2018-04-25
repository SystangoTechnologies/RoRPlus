json.user do
  json.access_token access_token.token
  json.(current_user, :id, :email, :first_name, :last_name)
end
