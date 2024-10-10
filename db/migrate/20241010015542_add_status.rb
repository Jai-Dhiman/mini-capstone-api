class AddStatus < ActiveRecord::Migration[7.1]
  def change
    add_column :carted_products, :status, :string, default: "in_cart"
  end
end
