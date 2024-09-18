class CreateNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :notes do |t|
      t.text :body

      t.timestamps
    end
  end
end
