class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :name
      t.boolean :valid

      t.timestamps null: false
    end
  end
end
