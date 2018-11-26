class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates_length_of :description, minimum: 5
  validates :expire_at, inclusion: {in: (Date.today..Date.today + 5.years)}
  enum status: %i[todo done]

  scope :q, ->(q) { where("title LIKE '%#{q}%'") unless q.blank? }
  scope :status, ->(status) { where(status: status) unless status.blank? }
  scope :expired, ->(val) { where("expire_at #{val == 'Expired' ? '<' : '>'} ?", Time.now) unless val.blank? }
  scope :for_dashboard, ->(params, current_user) do
    users_tasks(current_user).q(params[:q]).status(params[:status]).expired(params[:expired])
  end

  scope :users_tasks, ->(current_user) {
    id = current_user.id
    friends = UserConnection.find_by_user_b_id(id)
    where(user_id: friends ? [id, friends.user_a_id] : id)
  }

end
