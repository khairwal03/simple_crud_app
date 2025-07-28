class AddSoftDeletedToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :soft_deleted, :boolean, null: false, default: false
    add_index  :items, :soft_deleted
  end
end
