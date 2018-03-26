class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_many :notes, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :active_relationships, foreign_key: "follower_id", class_name: "Relationship"
  has_many :passive_relationships, foreign_key: "following_id", class_name: "Relationship"

  has_many :followings, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower

end
