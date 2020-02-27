# frozen_string_literal: true

class CreatePostcodeWhitelists < ActiveRecord::Migration[6.0]
  def change
    create_table :postcode_whitelists do |t|
      t.string :postcode, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
