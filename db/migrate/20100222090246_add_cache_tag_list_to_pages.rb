class AddCacheTagListToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :cached_tag_list, :string
  end

  def self.down
    remove_column :pages, :cached_tag_list, :string
  end
end
