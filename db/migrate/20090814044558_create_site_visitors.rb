class CreateSiteVisitors < ActiveRecord::Migration
  def self.up
    create_table :site_visitors do |t|
      t.string :cookie
      t.datetime :first_visit
      t.datetime :latest_visit

      t.timestamps
    end
  end

  def self.down
    drop_table :site_visitors
  end
end
