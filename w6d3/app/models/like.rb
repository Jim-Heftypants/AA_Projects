class Like < ApplicationRecord
    validates :user_id, :likeable_id, :likeable_type, presence: true
    validates :likeable_id, uniqueness: { scope: :likeable_type, message: "Likes must be unique" }

    belongs_to :likeable, :polymorphic => true

    belongs_to :user,
        foreign_key: :user_id,
        class_name: :User
end
