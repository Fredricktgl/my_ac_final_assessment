class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
  has_many :relationshipsnotes, dependent: :destroy
  has_many :notes, through: :relationshipsnotes

end
