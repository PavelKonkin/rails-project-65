# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    user_info = request.env['omniauth.auth']
    email = user_info['info']['email'].downcase
    name = user_info['info']['nickname']

    # TODO: Убрать после демонстрации
    admin = true

    @current_user = User.find_or_initialize_by(email:)
    if @current_user.new_record?
      @current_user.name = name
      # TODO: Убрать admin после демонстрации
      @current_user.admin = admin
      @current_user.save
    end
    sign_in @current_user
    redirect_to root_path, notice: t('.signed_in')
  end
end
