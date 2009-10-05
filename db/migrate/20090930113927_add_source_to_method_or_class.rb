class AddSourceToMethodOrClass < ActiveRecord::Migration
  def self.up
    add_column :method_or_classes, :source, :string
  end

  def self.down
    remove_column :method_or_classes, :source
  end
end
