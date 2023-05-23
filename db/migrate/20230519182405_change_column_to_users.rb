# frozen_string_literal: true

class ChangeColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    User.find_by(email: 'idmfani@gmail.com')&.update(admin: true)
  end
end
