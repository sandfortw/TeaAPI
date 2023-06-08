# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.integer :price
      t.references :customer, null: false, foreign_key: true
      t.integer :status, default: 0
      t.integer :frequency, default: 0

      t.timestamps
    end
  end
end
