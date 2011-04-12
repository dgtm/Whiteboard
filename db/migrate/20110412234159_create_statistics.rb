class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
      t.integer :user_id
      t.integer :document_id
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :statistics
  end
end
