# frozen_string_literal: true

# Add the role_types table to store the role type dictionary
class CreateRoleTypes < ActiveRecord::Migration
  def change
    create_table :role_types do |t|
      t.string :key, null: false, comment: 'The identifier for the role type'
      t.text :description, null: false, comment: 'A description of the role'
      t.timestamps

      t.index :key, unique: true
    end
  end
end
