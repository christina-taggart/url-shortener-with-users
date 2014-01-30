class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |col|
      col.string :long_url
      col.string :short_key
    end
  end
end
