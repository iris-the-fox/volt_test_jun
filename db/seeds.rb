# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
User.destroy_all
Post.destroy_all
Comment.destroy_all

test_user = { nickname: 'first_user', email: 'example@email.com', password: 'somepass' }
all_users =[test_user]

10.times do 
	all_users << { nickname: Faker::HarryPotter.character,
	               email: Faker::Internet.safe_email,
	               password: Faker::Internet.password 
               }
end

users = User.create!(all_users)


all_posts = []

users.each do |user|
  rand(1..5).times do
    all_posts << { author_id: user.id,
                   title: Faker::Lorem.word,
                   body: Faker::HarryPotter.quote,
                   published_at: Faker::Time.between(DateTime.current - 10, DateTime.current) 
                 }
  end
end

posts = Post.create!(all_posts)


all_comments = []

posts.each do |post|
  rand(1..5).times do
    all_comments << { post_id: post.id,
                      author_id: users[rand(10)].id,
                      body: Faker::HarryPotter.spell,
                      published_at: Faker::Time.between(post.published_at, DateTime.now) 
                    }
  end
end

comments = Comment.create!(all_comments)

