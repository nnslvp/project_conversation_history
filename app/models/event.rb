class Event < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :content, presence: true, if: -> { from_status.blank? && to_status.blank? }

  validates :to_status, inclusion: Project.statuses.keys, if: -> { to_status.present? }
  validates :to_status, presence: true, inclusion: Project.statuses.keys, if: -> { content.blank? }

  validates :from_status, inclusion: Project.statuses.keys, if: -> { from_status.present? }

  validate :different_statuses

  def status_change?
    from_status.present? || to_status.present?
  end

  private

  def different_statuses
    if from_status.present? && to_status.present? && from_status == to_status
      errors.add(:to_status, "cannot be the same as from_status")
    end
  end
end
