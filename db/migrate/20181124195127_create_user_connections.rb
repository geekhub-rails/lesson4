class CreateUserConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :user_connections do |t|
      t.string :user_a_id
      t.integer :user_b_id
    end
  end
end
