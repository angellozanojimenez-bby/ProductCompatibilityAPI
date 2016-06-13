class CorrectTablesWithTheirRightValues < ActiveRecord::Migration
  def change
    # We need to adjust the values in the tables to be able to match our
    # current project's goals.
    change_table :products do |t|
      t.remove :email, :encrypted_password, :reset_password_token,
      :reset_password_sent_at, :remember_created_at, :sign_in_count,
      :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
      :last_sign_in_ip
      t.string :title, default: ""
      t.string :maker, default: ""
      t.integer :sku_number, default: nil

    end

    change_table :relations do |t|
      t.remove :email, :encrypted_password, :reset_password_token,
      :reset_password_sent_at, :remember_created_at, :sign_in_count,
      :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
      :last_sign_in_ip
      t.integer :sku_one, default: nil
      t.integer :sku_two, default: nil
      t.string :relation_type, default: ""
    end

    change_table :users do |t|
      t.integer :employee_number, default: nil
      t.integer :score, default: nil
    end
  end
end
