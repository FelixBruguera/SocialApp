class Friend < ApplicationRecord
    extend FriendlyId
    belongs_to :user
    belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
    friendly_id :uuid, use: :slugged
end
