# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :first_name, :last_name
end
