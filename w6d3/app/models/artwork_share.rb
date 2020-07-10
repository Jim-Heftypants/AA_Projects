class ArtworkShare < ApplicationRecord
    validates :artwork_id, :viewer_id, presence: true
    validates :viewer_id, uniqueness: { scope: :artwork_id, message: "artwork cannot be shared twice to same user" }
    validate :favorite_id_match_or_null

    #make sure users_who_favorited_id == viewer_id or NULL
    def favorite_id_match_or_null
        (users_who_favorited_id.nil? || users_who_favorited_id == viewer_id ) && 
        (favorited_artwork_id.nil? || favorited_artwork_id == artwork_id)
    end

    belongs_to :viewer,
        foreign_key: :viewer_id,
        class_name: :User

    belongs_to :artwork,
        foreign_key: :artwork_id,
        class_name: :Artwork

    belongs_to :favorited_artist,
          foreign_key: :users_who_favorited_id,
          class_name: :Artwork

    belongs_to :favorited_artwork,
          foreign_key: :favorited_artwork_id,
          class_name: :User
end
