class Task < ApplicationRecord
  validates :title, presence: true

  validates :description,
            presence: true,
            length: {minimum: 5}

  validate :expire_at_cannot_be_in_the_past

  def expire_at_cannot_be_in_the_past
    if expire_at.present? && expire_at < Date.today
      errors.add(:expire_at, "can't be in the past")
    end
  end

end
