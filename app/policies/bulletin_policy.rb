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

  private

  def author?
    @record.user == @user
  end
end
