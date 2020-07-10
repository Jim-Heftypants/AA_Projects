class UniqueUserArtworkPairCollectionsTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :collections, :artwork_id
    add_column :collections, :artwork_id, :integer, null: false
    add_index :collections, [:artwork_id, :user_id], unique: true
  end
end
