class TasksController < ApplicationController
  PAR = 10
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  def new
    @task = Task.new
  end
  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to task_path(@task.id),notice: %(タスクを登録しました。)
    else
      flash.now[:danger] = %(タスクの登録に失敗しました。)
      render :new
    end
  end
  def index
      @tasks = Task.all.recent
      @tasks = Task.page(params[:page]).per(PAR)
      # @tasks = Task.recent.page(params[:page]).per(PAR)

    if params[:order_valid].present?
      # @tasks = Task.all.recent
      # @tasks = Task.sort_by{ |task| task.valid_date }
      @tasks = Task.order_valid
      @tasks = Task.page(params[:page]).per(PAR)
      # @tasks = @tasks.sort_by{ |task| task.valid_date }

    elsif params[:status].present? && params[:task_name].present?
      @tasks = @tasks.search_status(params[:status]).search_name_like(params[:task_name])

    elsif params[:task_name].present?
      @tasks = @tasks.search_name_like(params[:task_name])

    elsif params[:status].present?
      @tasks = @tasks.search_status(params[:status])

    elsif params[:order_priority].present?
      @tasks = Task.order_priority
      @tasks = Task.page(params[:page]).per(PAR)
      # @tasks = @tasks.order_priority.page(params[:page].per(PAR))
      # @tasks = Task.order_priority.page(params[:page].per(PAR))
    end

  end
  def show

  end
  def edit

  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: %(タスクを編集しました。)
    else
      flash.now[:danger] = %(タスクの編集に失敗しました。)
      render :edit
    end
  end
  def destroy
    if @task.delete
      redirect_to tasks_path, notice: %(タスクを削除しました。)
    else
      flash.now[:danger] = %(タスクの削除に失敗しました。)
      render :index
    end
  end
  private
  def set_task
    @task = Task.find_by(id: params[:id])
  end
  def task_params
    params.require(:task).permit(:task_name, :details, :valid_date, :status)
  end
  # def search_params
  #   params.fetch(:search, {}).permit(:task_name, :status)
  # end
end
