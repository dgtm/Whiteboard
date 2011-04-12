class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.integer :number
      t.integer :user_id
      t.integer :document_id
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :versions
  end
end
