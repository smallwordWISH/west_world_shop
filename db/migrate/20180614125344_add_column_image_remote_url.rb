class AddColumnImageRemoteUrl < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :image_remote_url, :string
  end
end
