class Api::V0::AuthController < ApiApplicationController
  def create
    raise ActionController::BadRequest if %w[grant_type credential].any? { |field| auth_params[field].blank? }

    success, user = User.auth(auth_params)
    if success
      render json: {
        success: success,
        access_token: user.generate_access_token,
        refresh_token: user.generate_refresh_token
      }, status: :ok
    else
      render json: { success: success, error: 'Invalid credentail' }, status: :ok
    end
  end

  private

  def auth_params
    params.permit(:grant_type, credential: {})
  end
end
