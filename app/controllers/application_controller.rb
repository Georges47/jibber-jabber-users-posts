class ApplicationController < ActionController::API
  def authenticate_user
    # Checks the request for an authentication bearer header
    pattern = /^Bearer /
    header = request.headers['Authorization']
    if header && header.match(pattern)
      access_token = header.gsub(pattern, '')
    else
      render json: { errors: 'Missing/Invalid authorization header' }, status: :unauthorized and return
    end

    # Checks the bearer value for a valid jwt
    public_key = OpenSSL::PKey.read(ENV['KEYCLOAK_REALM_PUBLIC_KEY'])
    begin
      @decoded_token = JWT.decode access_token, public_key, true, { algorithm: 'RS256' }
    rescue JWT::DecodeError, ArgumentError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
