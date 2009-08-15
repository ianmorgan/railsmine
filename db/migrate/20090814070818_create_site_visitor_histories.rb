class CreateSiteVisitorHistories < ActiveRecord::Migration
  def self.up
    create_table :site_visitor_histories do |t|
      t.integer :site_visitor_id
      t.string :displayable_string
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :site_visitor_histories
  end
end
