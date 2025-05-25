class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :status, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :projects, :status
  end
end
