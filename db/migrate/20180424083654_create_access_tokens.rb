class CreateAccessTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :access_tokens do |t|
      t.string :token, null: false
      t.boolean :active, null: false, default: true
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
