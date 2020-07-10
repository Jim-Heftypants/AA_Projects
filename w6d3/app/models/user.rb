class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :artworks,
        foreign_key: :artist_id,
        class_name: :Artwork,
        dependent: :destroy

    has_many :viewed_artworks,
        foreign_key: :viewer_id,
        class_name: :ArtworkShare,
        dependent: :destroy

    has_many :shared_artworks,
        through: :viewed_artworks,
        source: :artwork

    has_many :comments,
        foreign_key: :author_id,
        class_name: :Comment,
        dependent: :destroy

    has_many :likes,
        foreign_key: :user_id,
        class_name: :Like,
        dependent: :destroy
        
    has_many :liked_artworks,
        through: :artworks,
        source: :likes

    has_many :liked_comments,
        through: :comments,
        source: :likes

    has_one :collection,
        foreign_key: :user_id,
        class_name: :Collection,
        dependent: :destroy

    has_many :favorited_artworks,
      foreign_key: :favorited_artwork_id,
      class_name: :ArtworkShare
    
end

#artist -> artwork -share-> other_users
#