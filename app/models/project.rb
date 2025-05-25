class Project < ApplicationRecord
  belongs_to :user
  enum :status, {
    draft: 0,
    in_progress: 1,
    completed: 2,
    archived: 3
  }
end
