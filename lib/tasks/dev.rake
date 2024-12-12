desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  puts "Sample data task running"
  if Rails.env.development?
    User.destroy_all
    Task.destroy_all
    TaskCategory.destroy_all
    Review.destroy_all
  end
  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

  
  usernames = ["alice", "bob", "carol", "dave", "eve"]
  usernames.each do |username|
    user = User.new
    user.email = "#{username}@example.com"
    user.password = "password"
    user.save
  end

  5.times do
    task_category = TaskCategory.new
    task_category.name = Faker::Job.field
    task_category.desc = Faker::Lorem.sentence(word_count: 10)
    task_category.save
  end

  TaskCategory.all.each do |category|
    rand(10..50).times do
      task = Task.new
      task.title = Faker::Company.catch_phrase
      task.description = Faker::Lorem.paragraph(sentence_count: 3)
      task.category_id = category.id
      task.fee = Faker::Commerce.price(range: 10..100)
      task.deadline = Faker::Date.forward(days: rand(1..3))
      task.location = Faker::Address.full_address
      task.requester_id = User.all.sample.id
      task.status = "requested"
      task.save
    

      # also making some fake sample reviews
      rand(0..1).times do
        review = Review.new
        review.task_id = task.id
        review.reviewer_id = User.all.sample.id
        rating = rand(1..5)
        comment = Faker::Lorem.sentence(word_count: 10)
        review.save
      end
    end
  end



  puts "There are now #{User.count} rows in the user table."
  puts "There are now #{TaskCategory.count} rows in the task_categories table."
  puts "There are now #{Task.count} rows in the tasks table."
  puts "There are now #{Review.count} rows in the reviews table."
end
