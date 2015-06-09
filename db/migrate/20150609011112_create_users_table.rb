class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.string :email
      t.string :password_digest
      t.string :name
    end
  end
end
