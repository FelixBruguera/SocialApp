class Post < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :reactions
    has_one_attached :image
    # has_one :shared_post, class_name: 'Post', foreign_key: 'shared_post'
    # belongs_to :post, class_name: 'Post', foreign_key: 'shared_post'
    has_many :shares, class_name: 'Post', foreign_key: 'shared_post'
    has_many :notifications
end
