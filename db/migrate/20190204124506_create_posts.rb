class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.references :author, index: true, foreign_key: {to_table: :users}
      t.datetime :published_at, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
