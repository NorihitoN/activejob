class TasksController < ApplicationController
  
  
  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)

      SbibankCrawlerJob.perform_later('Task exec.')

    if @task.save
      
      SbibankCrawlerJob.set(wait: 10.second).perform_later(@task.title)
      #SbibankCrawlerJob.set(wait: 15.second).run_later(@task.id, @task.title)
      
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end
end

private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:title)
  end