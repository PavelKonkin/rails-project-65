# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  include AuthUserConcern
  before_action :authenticate_user

  def show
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.where(user: current_user).order(created_at: :desc).page(params[:page])
    @states = Bulletin.aasm.states.map(&:name)
  end
end
