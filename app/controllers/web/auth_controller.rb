# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    user_info = request.env['omniauth.auth']
    email = user_info['info']['email'].downcase
    name = user_info['info']['nickname']
    @current_user = User.find_by(email:)
    @current_user ||= User.create(name:, email:)
    sign_in @current_user
    redirect_to root_path, notice: t('success')
  end
end
