class TasksController < ApplicationController
  PAR = 10
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  def new
    @task = Task.new
    @task.managers.build
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: %(タスクを登録しました。)
    else
      flash.now[:danger] = %(タスクの登録に失敗しました。)
      render :new
    end
  end
  def index
    if logged_in?
      @tasks = current_user.tasks.page(params[:page]).per(PAR)

      if params[:order_valid].present?
        @tasks = @tasks.order_valid

      elsif params[:status].present? && params[:task_name].present?
        @tasks = @tasks.search_status(params[:status]).search_name_like(params[:task_name])

      elsif params[:task_name].present?
        @tasks = @tasks.search_name_like(params[:task_name])

      elsif params[:status].present?
        @tasks = @tasks.search_status(params[:status])

      elsif params[:order_priority].present?
        @tasks = @tasks.order_priority

      elsif params[:label_id].present?
        label = Label.find_by(id: params[:label_id])
        @tasks = label.managers.map { |m| m.task }
        @tasks = Kaminari.paginate_array(@tasks).page(params[:page]).per(PAR)
      else
        @tasks = @tasks.recent
      end
    end
  end
  def show
    @label_ids = @task.managers.map { |man| man.label_id }
  end
  def edit
    @task.managers.build
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
  def set_label
    @label = Label.where(user_id: [nil, current_user.id])
  end
  def task_params
    params.require(:task).permit(:task_name, :details, :valid_date, :status, :priority).merge(user_id: current_user.id, label_ids: params[:task][:label_ids])
  end
end
