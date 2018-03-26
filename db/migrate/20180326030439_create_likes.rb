class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :note, foreign_key: true
      t.timestamps
    end

    add_index :likes, [:user_id, :note_id], unique: true

  end
end
