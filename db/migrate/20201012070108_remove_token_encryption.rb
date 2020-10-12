class RemoveTokenEncryption < ActiveRecord::Migration[5.2]
  def change
    remove_column(:users, :encrypted_token, :string)
    remove_column(:users, :encrypted_token_iv, :string)
    add_column(:users, :token, :string)
  end
end
