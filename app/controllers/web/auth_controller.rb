# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    user_info = receive_user_info
    user = User.find_or_initialize_by(email: user_info[:email])
    user.name = user_info[:name]

    # TODO: Убрать admin после демонстрации
    user.admin = true

    user.save if user.changed?

    sign_in user

    redirect_to root_path, notice: t('.signed_in')
  end

  private

  def receive_user_info
    info = request.env['omniauth.auth']['info']
    { email: info['email'].downcase, name: info['nickname'] }
  end
end
