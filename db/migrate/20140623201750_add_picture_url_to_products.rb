class AddPictureUrlToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :picture_url, :string
  end
end
