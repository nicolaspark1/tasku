class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy, :take_on, :complete]
  before_action :authorize_task_user, only: [:update, :destroy]

  def authorize_task_user
    unless @the_task.requester_id == current_user.id || current_user.role == "admin"
      redirect_to tasks_path, alert: "You are not authorized to perform this action."
    end
  end

  def index
    matching_tasks = Task.all

    @list_of_tasks = matching_tasks.order({ :created_at => :desc })

    matching_task_categories = TaskCategory.all
    @list_of_task_categories = matching_task_categories.order({ :created_at => :desc })

    render({ :template => "tasks/index" })
  end

  def show
    render({ :template => "tasks/show" })
  end

  def create
    the_task = Task.new
    the_task.title = params.fetch("query_title")
    the_task.description = params.fetch("query_description")
    the_task.category_id = params.fetch("query_category_id")
    the_task.fee = params.fetch("query_fee")
    the_task.deadline = params.fetch("query_deadline")

    the_task.location = params.fetch("query_location")
    the_task.requester_id = current_user.id if user_signed_in?
    the_task.status = "requested"

    if the_task.valid?
      the_task.save
      redirect_to("/tasks", { :notice => "Task created successfully." })
    else
      redirect_to("/tasks", { :alert => the_task.errors.full_messages.to_sentence })
    end
  end

  def update
    @the_task.title = params.fetch("query_title")
    @the_task.description = params.fetch("query_description")
    @the_task.category_id = params.fetch("query_category_id")
    @the_task.fee = params.fetch("query_fee")
    @the_task.deadline = params.fetch("query_deadline")
    @the_task.location = params.fetch("query_location")
    @the_task.requester_id = params.fetch("query_requester_id")
    @the_task.status = params.fetch("query_status")
    @the_task.accepted_at = params.fetch("query_accepted_at")
    @the_task.completed_at = params.fetch("query_completed_at")
    @the_task.tasker_id = params.fetch("query_tasker_id")
    @the_task.reviews_count = params.fetch("query_reviews_count")

    if @the_task.valid?
      @the_task.save
      redirect_to("/tasks/#{@the_task.id}", { :notice => "Task updated successfully."} )
    else
      redirect_to("/tasks/#{@the_task.id}", { :alert => @the_task.errors.full_messages.to_sentence })
    end
  end

  def destroy
    @the_task.destroy

    redirect_to("/tasks", { :notice => "Task deleted successfully."} )
  end

  def take_on
    if @the_task.status == "requested"
      @the_task.tasker_id = current_user.id
      @the_task.status = "in progress"
      @the_task.save
      redirect_to("/tasks/#{@the_task.id}", notice: "You have taken on this task.")
    else
      redirect_to("/tasks/#{@the_task.id}", alert: "This task cannot be taken on.")
    end
  end

  def complete
    if @the_task.status == "in progress" && @the_task.tasker_id == current_user.id
      @the_task.status = "complete"
      @the_task.completed_at = Time.now
      @the_task.save
      redirect_to task_path(@the_task), notice: "You have completed this task."
    else
      redirect_to task_path(@the_task), alert: "This task cannot be completed."
    end
  end

  private

  def set_task
    @the_task = Task.find(params.fetch("path_id"))
  end
end
