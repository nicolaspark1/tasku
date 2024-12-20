Rails.application.routes.draw do
  # devise_for :users

  root to: "tasks#index"

  # routes for taskers
  post "/tasks/:path_id/take_on", { :controller => "tasks", :action => "take_on" }
  post "/tasks/:path_id/complete", { :controller => "tasks", :action => "complete" }


  # Routes for the Review resource:

  # CREATE
  post("/insert_review", { :controller => "reviews", :action => "create" })
          
  # READ
  get("/reviews", { :controller => "reviews", :action => "index" })
  
  get("/reviews/:path_id", { :controller => "reviews", :action => "show" })
  
  # UPDATE
  
  post("/modify_review/:path_id", { :controller => "reviews", :action => "update" })
  
  # DELETE
  get("/delete_review/:path_id", { :controller => "reviews", :action => "destroy" })

  #------------------------------

  # Routes for the Task category resource:

  # CREATE
  post("/insert_task_category", { :controller => "task_categories", :action => "create" })
          
  # READ
  get("/task_categories", { :controller => "task_categories", :action => "index" })
  
  get("/task_categories/:path_id", { :controller => "task_categories", :action => "show" })
  
  # UPDATE
  
  post("/modify_task_category/:path_id", { :controller => "task_categories", :action => "update" })
  
  # DELETE
  get("/delete_task_category/:path_id", { :controller => "task_categories", :action => "destroy" })

  #------------------------------

  # Routes for the Task resource:

  # CREATE
  post("/insert_task", { :controller => "tasks", :action => "create" })
          
  # READ
  get("/tasks", { :controller => "tasks", :action => "index" })
  
  get("/tasks/:path_id", { :controller => "tasks", :action => "show" })
  
  # UPDATE
  
  post("/modify_task/:path_id", { :controller => "tasks", :action => "update" })
  
  # DELETE
  get("/delete_task/:path_id", { :controller => "tasks", :action => "destroy" })

  #------------------------------

  devise_for :users

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
