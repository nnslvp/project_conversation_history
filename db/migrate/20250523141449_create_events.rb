class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.string :from_status
      t.string :to_status

      t.timestamps
    end
  end
end
