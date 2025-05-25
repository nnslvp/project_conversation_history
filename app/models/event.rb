class Event < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :content, presence: true, if: -> { from_status.blank? && to_status.blank? }
  validates :to_status, presence: true, if: -> { content.blank? }

  scope :ordered, -> { order(created_at: :desc) }

  def status_change?
    from_status.present? || to_status.present?
  end
end
