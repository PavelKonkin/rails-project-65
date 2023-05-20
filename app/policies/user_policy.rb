# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    false
  end

  def update?
    admin?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
end
