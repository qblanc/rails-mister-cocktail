class RenameDosesDescriptionToQuantity < ActiveRecord::Migration[5.2]
  def change
    rename_column :doses, :description, :quantity
  end
end
