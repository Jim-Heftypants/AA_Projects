class AddFavoritesColumns < ActiveRecord::Migration[5.2]
  def change
    # add_column :artworks, :whether_owner_has_favorited, :integer
    add_column :artwork_shares, :users_who_favorited_id, :integer
    add_column :artwork_shares, :favorited_artwork_id, :integer
  end
end

# users.favotited_artworks => many => artwork_shares
# artworks.favorited_users => many => artwork_shares

# artworks
# has_many :users_who_favorited
#   foreign_key: :users_who_favorited_id
#   class_name: :ArtworkShare

# artwork_shares
# belongs_to :favorited_artist
#   foreign_key: :users_who_favorited_id
#   class_name: :Artwork
# belongs_to :favorited_artwork
#   foreign_key: :favorited_artwork_id
#   class_name: :Users

# users
# has_many :favorited_artworks,
#   foreign_key: :favorited_artwork_id,
#   class_name: :Artwork_share

# users
# has_many :favorited_artworks
# through: :
# source: :

# users
# id    username
# 1     wakka     
# 2     mike
# 3     


# artworks
# id  


# artwork_shares
# id     viewer_id     artwork_id     users_who_favorited_id      favorited_artwork_id
# 1              1              1                     1/NULL                    1/NULL
# 2              1              3