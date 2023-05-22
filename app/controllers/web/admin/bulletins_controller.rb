# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.order(created_at: :desc)
    authorize @bulletins
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def publish
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
    @bulletin.publish!
    redirect_to admin_root_path, notice: t('.published')
  end

  def to_archive
    bulletin = Bulletin.find(params[:id])
    authorize bulletin
    bulletin.to_archive!
    redirect_to admin_root_path, notice: t('.archived')
  end

  def reject
    bulletin = Bulletin.find(params[:id])
    authorize bulletin
    bulletin.reject!
    redirect_to admin_root_path, notice: t('.rejected')
  end
end
