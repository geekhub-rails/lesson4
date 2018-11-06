class WelcomeController < ApplicationController
	http_basic_authenticate_with name: "slavik", password: "123456"
  def index
    @task = Task.new
    @tasks = Task.all.order(id: :desc)
  end
end
