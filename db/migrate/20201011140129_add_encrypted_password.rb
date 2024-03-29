class AddEncryptedPassword < ActiveRecord::Migration[5.2]
  def change
    add_column(:users, :encrypted_password, :string)
    add_column(:users, :encrypted_password_iv, :string)
    add_column(:users, :encrypted_token, :string)
    add_column(:users, :encrypted_token_iv, :string)
  end
end
