class CreateMessage < ActiveRecord::Migration[5.2]
  def up
  	create_table :messages do |t|
  		t.string :body
  		t.text :link
  	end
  end

  def down
  	drop_table :messages
	end
end
