# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include AuthUserConcern

  helper_method :current_user, :sign_in, :sign_out, :signed_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('.You are not authorized to perform this action.')
    redirect_back(fallback_location: root_path)
  end
end
