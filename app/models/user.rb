class User < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_many :reactions
  has_many :friends
  has_many :friend_requests, foreign_key: :receiver
  has_many :friend_requests_sent, foreign_key: :sender, class_name: 'FriendRequest'
  has_one_attached :profile_picture
  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'sender'
  has_many :notifications, class_name: 'Notification', foreign_key: 'receiver'
  has_one_attached :cover_picture
  friendly_id :username, use: :slugged
end
