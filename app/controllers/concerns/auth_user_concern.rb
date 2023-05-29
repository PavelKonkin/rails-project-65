# frozen_string_literal: true

module AuthUserConcern
  def authenticate_user
    return if user_signed_in?

    redirect_to root_path, alert: t('.forbidden')
  end

  def user_signed_in?
    current_user
  end
end
