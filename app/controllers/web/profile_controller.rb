# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :authenticate_user

  def show
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.where(user: current_user).order(created_at: :desc).page(params[:page])
  end
end
