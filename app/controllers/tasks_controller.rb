class TasksController < ApplicationController
  def index
    matching_tasks = Task.all

    @list_of_tasks = matching_tasks.order({ :created_at => :desc })

    render({ :template => "tasks/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_tasks = Task.where({ :id => the_id })

    @the_task = matching_tasks.at(0)

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
    the_task.requester_id = params.fetch("query_requester_id")
    the_task.status = params.fetch("query_status")
    the_task.accepted_at = params.fetch("query_accepted_at")
    the_task.completed_at = params.fetch("query_completed_at")
    the_task.tasker_id = params.fetch("query_tasker_id")
    the_task.reviews_count = params.fetch("query_reviews_count")

    if the_task.valid?
      the_task.save
      redirect_to("/tasks", { :notice => "Task created successfully." })
    else
      redirect_to("/tasks", { :alert => the_task.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_task = Task.where({ :id => the_id }).at(0)

    the_task.title = params.fetch("query_title")
    the_task.description = params.fetch("query_description")
    the_task.category_id = params.fetch("query_category_id")
    the_task.fee = params.fetch("query_fee")
    the_task.deadline = params.fetch("query_deadline")
    the_task.location = params.fetch("query_location")
    the_task.requester_id = params.fetch("query_requester_id")
    the_task.status = params.fetch("query_status")
    the_task.accepted_at = params.fetch("query_accepted_at")
    the_task.completed_at = params.fetch("query_completed_at")
    the_task.tasker_id = params.fetch("query_tasker_id")
    the_task.reviews_count = params.fetch("query_reviews_count")

    if the_task.valid?
      the_task.save
      redirect_to("/tasks/#{the_task.id}", { :notice => "Task updated successfully."} )
    else
      redirect_to("/tasks/#{the_task.id}", { :alert => the_task.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_task = Task.where({ :id => the_id }).at(0)

    the_task.destroy

    redirect_to("/tasks", { :notice => "Task deleted successfully."} )
  end
end