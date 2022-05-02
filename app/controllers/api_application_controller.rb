class ApiApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
  respond_to :json
end
