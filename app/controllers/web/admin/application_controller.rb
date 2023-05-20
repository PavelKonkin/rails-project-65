# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authenticate_admin

  def admin_signed_in?
    current_user.admin?
  end

  def authenticate_admin
    return if admin_signed_in?

    flash[:error] = t('forbidden')
    redirect_to root_path
  end
end
