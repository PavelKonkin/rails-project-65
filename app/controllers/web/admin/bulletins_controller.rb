# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
    @states = Bulletin.aasm.states.map(&:name)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def publish
    bulletin = Bulletin.find(params[:id])
    authorize bulletin
    if bulletin.may_publish?
      bulletin.publish!
      redirect_to admin_root_path, notice: t('.published')
    else
      redirect_to admin_root_path, notice: t('.may_not_be_published')
    end
  end

  def archive
    bulletin = Bulletin.find(params[:id])
    authorize bulletin
    if bulletin.may_to_archive?
      bulletin.to_archive!
      redirect_to admin_root_path, notice: t('.archived')
    else
      redirect_to admin_root_path, notice: t('.may_not_send_to_archive')
    end
  end

  def reject
    bulletin = Bulletin.find(params[:id])
    authorize bulletin
    if bulletin.may_reject?
      bulletin.reject!
      redirect_to admin_root_path, notice: t('.rejected')
    else
      redirect_to admin_root_path, notice: t('.may_not_be_rejected')
    end
  end
end
