class AddMethodNameToMethodOrClass < ActiveRecord::Migration
  def self.up
    remove_column :method_or_classes, :name
    add_column :method_or_classes, :method_name, :text
    add_column :method_or_classes, :class_name, :text
  end

  def self.down
    remove_column :method_or_classes, :class_name
    remove_column :method_or_classes, :method_name
    add_column :method_or_classes, :name, :string
  end
end
                                          