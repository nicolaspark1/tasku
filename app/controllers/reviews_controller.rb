class ReviewsController < ApplicationController
  def index
    matching_reviews = Review.all

    @list_of_reviews = matching_reviews.order({ :created_at => :desc })

    render({ :template => "reviews/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_reviews = Review.where({ :id => the_id })

    @the_review = matching_reviews.at(0)

    render({ :template => "reviews/show" })
  end

  def create
    the_review = Review.new
    the_review.task_id = params.fetch("query_task_id")
    the_review.reviewer_id = params.fetch("query_reviewer_id")
    the_review.rating = params.fetch("query_rating")
    the_review.comment = params.fetch("query_comment")

    if the_review.valid?
      the_review.save
      redirect_to("/reviews", { :notice => "Review created successfully." })
    else
      redirect_to("/reviews", { :alert => the_review.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_review = Review.where({ :id => the_id }).at(0)

    the_review.task_id = params.fetch("query_task_id")
    the_review.reviewer_id = params.fetch("query_reviewer_id")
    the_review.rating = params.fetch("query_rating")
    the_review.comment = params.fetch("query_comment")

    if the_review.valid?
      the_review.save
      redirect_to("/reviews/#{the_review.id}", { :notice => "Review updated successfully."} )
    else
      redirect_to("/reviews/#{the_review.id}", { :alert => the_review.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_review = Review.where({ :id => the_id }).at(0)

    the_review.destroy

    redirect_to("/reviews", { :notice => "Review deleted successfully."} )
  end
end
