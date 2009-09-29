class CreateMethodOrClasses < ActiveRecord::Migration
  def self.up
    create_table :method_or_classes do |t|
      t.string :name
      t.boolean :is_method
      t.boolean :is_class
      t.integer :document_id
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :method_or_classes
  end
end
