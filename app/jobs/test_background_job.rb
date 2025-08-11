class TestBackgroundJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "This is running in background via Sidekiq!"
  end
end

