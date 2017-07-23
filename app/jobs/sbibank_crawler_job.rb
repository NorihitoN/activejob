class SbibankCrawlerJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    Task.new.exec(message)
  end
  
  def run(task_id, task_title)
    task = Task.find(task_id)
    task.title = task_title + " Done"
    task.save
  end
  
end
