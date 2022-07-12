class UsersController < ApplicationController
  before_action :authenticate_user

  def show
    user_keycloak_id = params['id']
    user = User.find_by_keycloak_id(user_keycloak_id)

    user = {
      id: user.keycloak_id,
      displayName: user.display_name,
      username: user.username,
      avatar: user.avatar
    }

    render json: user
  end

  def check_user
    decoded_token = @decoded_token[0]
    user_keycloak_id = decoded_token['sub']
    display_name = decoded_token['display_name']
    username = decoded_token['preferred_username']

    unless User.exists?(keycloak_id: user_keycloak_id)
      User.create(
        display_name: display_name,
        keycloak_id: user_keycloak_id,
        username: username,
      )
    end
  end
end
