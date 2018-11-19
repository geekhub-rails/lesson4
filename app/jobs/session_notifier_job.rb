class SessionNotifierJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sleep 3
    p 'Logged In!'
  end
end
