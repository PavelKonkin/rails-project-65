# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    true
  end

  def create?
    @user
  end

  def new?
    create?
  end

  def update?
    author? || @user&.admin?
  end

  def edit?
    update?
  end

  def destroy?
    @user&.admin?
  end

  def to_moderation?
    author?
  end

  def archive?
    author? || @user&.admin?
  end

  def publish?
    @user&.admin?
  end

  def reject?
    @user&.admin?
  end

  private

  def author?
    @record.user == @user
  end
end
