class User < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :friend_requests, foreign_key: :receiver, dependent: :destroy
  has_many :friend_requests_sent, foreign_key: :sender, class_name: 'FriendRequest', dependent: :destroy
  has_one_attached :profile_picture, dependent: :destroy
  has_many :sent_notifications, class_name: 'Notification', foreign_key: 'sender', dependent: :destroy
  has_many :notifications, class_name: 'Notification', foreign_key: 'receiver', dependent: :destroy
  has_one_attached :cover_picture, dependent: :destroy
  friendly_id :username, use: :slugged
  has_many :chats, dependent: :destroy
  has_many :chats_friend, class_name: 'Chat', foreign_key: 'friend_id', dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :pages
end
