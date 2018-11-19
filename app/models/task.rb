class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates_length_of :description, minimum: 5
  validates :expire_at, inclusion: { in: (Date.today..Date.today+5.years) }
  enum status: %i[todo done]

  scope :q, ->(q) { where("title LIKE '%#{q}%'") unless q.blank? }
  scope :status, ->(status) { where(status: status) unless status.blank? }
  scope :expired, ->(val) { where("expire_at #{val == 'Expired' ? '<' : '>'} ?", Time.now) unless val.blank?}
  scope :for_dashboard, ->(params) { q(params[:q]).status(params[:status]).expired(params[:expired]).paginate(page: params[:page], per_page: 5) }

end
