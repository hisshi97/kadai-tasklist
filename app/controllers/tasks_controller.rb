class TasksController < ApplicationController
  before_action :require_user_logged_in, except: [:index]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.page(params[:page]).per(5)
    end
  end
  
  def show 
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params) #current_userの確認
    
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end 
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  #Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = Task.find(params[:id])
    redirect_to root_url if @task.user != current_user
  end
end