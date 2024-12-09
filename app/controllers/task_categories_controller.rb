class TaskCategoriesController < ApplicationController
  def index
    matching_task_categories = TaskCategory.all

    @list_of_task_categories = matching_task_categories.order({ :created_at => :desc })

    render({ :template => "task_categories/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_task_categories = TaskCategory.where({ :id => the_id })

    @the_task_category = matching_task_categories.at(0)

    render({ :template => "task_categories/show" })
  end

  def create
    the_task_category = TaskCategory.new
    the_task_category.name = params.fetch("query_name")
    the_task_category.desc = params.fetch("query_desc")
    the_task_category.tasks_count = params.fetch("query_tasks_count")

    if the_task_category.valid?
      the_task_category.save
      redirect_to("/task_categories", { :notice => "Task category created successfully." })
    else
      redirect_to("/task_categories", { :alert => the_task_category.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_task_category = TaskCategory.where({ :id => the_id }).at(0)

    the_task_category.name = params.fetch("query_name")
    the_task_category.desc = params.fetch("query_desc")
    the_task_category.tasks_count = params.fetch("query_tasks_count")

    if the_task_category.valid?
      the_task_category.save
      redirect_to("/task_categories/#{the_task_category.id}", { :notice => "Task category updated successfully."} )
    else
      redirect_to("/task_categories/#{the_task_category.id}", { :alert => the_task_category.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_task_category = TaskCategory.where({ :id => the_id }).at(0)

    the_task_category.destroy

    redirect_to("/task_categories", { :notice => "Task category deleted successfully."} )
  end
end
