class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates_length_of :description, minimum: 5
  validates :expire_at, inclusion: { in: (Date.today..Date.today+5.years) }
  enum status: %i(todo done)

  scope :q, ->(q) { where("title LIKE '%#{q}%'") if q.present? }
  scope :s, ->(s) { where(status: s) if s && s != "all statuses" }
  scope :d, ->(d) { where(expire_at: d) if d.present? }
  scope :f, ->(f) do
    if f == "expired"
      where("expire_at < ?", Date.today)
    elsif f == "not expired"
      where("expire_at >= ?", Date.today)
    end
  end

  def done?
    status == "done"
  end

  alias done done?

  def done=(value)
    if value == '1'
      self.status = 1
    else
      self.status = 0
    end
  end

end
