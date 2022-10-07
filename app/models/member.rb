class Member < ApplicationRecord
  belongs_to :user
  has_many :tasks
  validates :email, presence: true
end
