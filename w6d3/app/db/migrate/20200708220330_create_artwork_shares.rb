class CreateArtworkShares < ActiveRecord::Migration[5.2]
  def change
    create_table :artwork_shares do |t|
      #change artist_id to artwork_id
      t.integer :artist_id, null: false
      t.integer :viewer_id, null: false

      t.timestamps
    end
    #remove artist_id
    add_index :artwork_shares, :artist_id
    add_index :artwork_shares, :viewer_id
    #add
    #add_index :artwork_shares, [:artwork_id, :viewer_id], unique: true
  end
end
