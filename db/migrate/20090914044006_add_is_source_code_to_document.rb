class AddIsSourceCodeToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :is_source_code, :string
  end

  def self.down
    remove_column :documents, :is_source_code
  end
end
