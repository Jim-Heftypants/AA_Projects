class FixArtworkShares < ActiveRecord::Migration[5.2]
  def change
    rename_column :artwork_shares, :artist_id, :artwork_id
  end
end
