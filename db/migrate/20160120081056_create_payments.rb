class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :amount #save money in cent
      t.string :reference_id #id of the charge object
    end
  end
end
