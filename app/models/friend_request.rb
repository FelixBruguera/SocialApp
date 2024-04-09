class FriendRequest < ApplicationRecord
    extend FriendlyId
    # belongs_to :sender, class_name: 'User', foreign_key: 'sender'
    # belongs_to :receiver, class_name: 'User', foreign_key: 'receiver'
    friendly_id :uuid, use: :slugged
end
