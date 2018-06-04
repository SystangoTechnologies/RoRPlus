class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :access_token

  def access_token
    scope[:access_token].token
  end
end
