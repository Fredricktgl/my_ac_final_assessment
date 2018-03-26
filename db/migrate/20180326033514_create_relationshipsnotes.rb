class CreateRelationshipsnotes < ActiveRecord::Migration[5.1]
  def change
    create_table :relationshipsnotes do |t|
      t.references :relationship, foreign_key: true
      t.references :note, foreign_key: true
      t.timestamps
    end

    add_index :relationshipsnotes, [:relationship_id, :note_id], unique: true

  end
end
