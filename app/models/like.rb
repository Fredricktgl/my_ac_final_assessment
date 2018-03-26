class Like < ApplicationRecord

  belongs_to :user, foreign_key: true
  belongs_to :note, foreign_key: true

end