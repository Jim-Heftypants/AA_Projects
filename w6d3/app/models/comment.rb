class Comment < ApplicationRecord
    validates :body, :author_id, :artwork_id, presence: true

    belongs_to :user,
        foreign_key: :author_id,
        class_name: :User
  
    belongs_to :artwork,
        foreign_key: :artwork_id,
        class_name: :Artwork

    has_many :likes, :as => :likeable

    has_many :likers,
        through: :likes,
        source: :user
end
