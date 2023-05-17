# frozen_string_literal: true

class Web::AuthController < ApplicationController
  def callback
    user_info = request.env["omniauth.auth"]
    email = user_info['info']['email'].downcase
    name = user_info['info']['nickname']
    @current_user = User.find_by(email: email)
    @current_user ||= User.create(name: name, email: email)
    sign_in @current_user
    redirect_to root_path
  end
end