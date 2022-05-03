class ApiApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
  protect_from_forgery with: :null_session, prepend: true
  respond_to :json
  rescue_from ActionController::BadRequest, with: :head_400
  rescue_from JWT::ExpiredSignature, with: :head_401

  def head_400
    render json: { success: false, error: 'Bad Request' }, status: :bad_request
  end

  def head_401
    render json: { success: false, error: 'Unauthorized' }, status: :unauthorized
  end

  def authenticate_user!
    return head_401 if request.headers['Authorization'].blank?

    token = request.headers['Authorization'].split(' ')[1]
    payload = JWT.decode token, ENV['SECRET_KEY'], true, { algorithm: 'HS256' }
    return head_401 if payload[0]['type'] != 'token'

    @current_user = User.find(payload[0]['id'])
  end
end
