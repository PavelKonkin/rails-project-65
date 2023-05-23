# frozen_string_literal: true

class Web::Profile::ApplicationController < Web::ApplicationController
  before_action :authenticate_user

  def user_signed_in?
    current_user
  end

  def authenticate_user
    return if user_signed_in?

    redirect_to root_path, alert: t('.forbidden')
  end
end
