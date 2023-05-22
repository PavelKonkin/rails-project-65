# frozen_string_literal: true

class Web::SessionController < Web::ApplicationController
  def destroy
    sign_out
    redirect_to root_path, notice: t('.signed_out')
  end
end
