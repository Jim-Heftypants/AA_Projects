class Artwork < ApplicationRecord
    validates :artist_id, :image_url, :title, presence: true
    validates :title, uniqueness: { scope: :artist_id, message: "artwork must be unique" }


    belongs_to :artist,
        foreign_key: :artist_id,
        class_name: :User

    has_many :artwork_shares,
        foreign_key: :artwork_id,
        class_name: :ArtworkShare,
        dependent: :destroy

    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer

    has_many :comments,
        foreign_key: :artwork_id,
        class_name: :Comment,
        dependent: :destroy

    has_many :likes, :as => :likeable, dependent: :destroy

    has_many :likers,
        through: :likes,
        source: :user

    has_many :collections,
        foreign_key: :artwork_id,
        class_name: :Collection,
        dependent: :destroy

    has_many :users_who_favorited,
      foreign_key: :users_who_favorited_id,
      class_name: :ArtworkShare

end