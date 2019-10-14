# frozen_string_literal: true

json.user do
  json.call(user, :id, :email, :first_name)
end
