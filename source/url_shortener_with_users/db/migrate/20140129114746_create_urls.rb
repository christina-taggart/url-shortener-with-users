class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :short, :long
      t.integer :clicks
      t.integer :user_id
    end
  end
end
