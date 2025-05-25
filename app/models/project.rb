class Project < ApplicationRecord
  belongs_to :user
  enum :status, {
    draft: 0,
    in_progress: 1,
    completed: 2,
    archived: 3
  }
  has_many :events, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
end
