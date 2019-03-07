class OpenedAtAndDestructionPolicy < ActiveRecord::Migration[5.2]
  def change
  	add_column :messages, :opened_at, :datetime
  	add_column :messages, :destruction_policy, :string
  end
end
