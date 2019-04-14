# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
TodoList.destroy_all

individuals = [{first_name: 'Carly', last_name: 'Fiorina', birth_year: 1954, gender: 'female'}, 
              {first_name: 'Donald', last_name: 'Trump', birth_year: 1946, gender: 'male'}, 
              {first_name: 'Ben', last_name: 'Carson', birth_year: 1951, gender: 'male'}, 
              {first_name: 'Hillary', last_name: 'Clinton', birth_year: 1947, gender: 'female'}]

individuals.each do |x|
  user = User.create(username: x[:last_name], password_digest: "password123")
  profile = Profile.create(first_name: x[:first_name], last_name: x[:last_name], birth_year: x[:birth_year], gender: x[:gender], user: user)
  list = TodoList.create(list_due_date: Date.today + 1.year, list_name: "#{user.username}'s list'", user: user)
end

count = 0

TodoList.all.each do |list|
  5.times do 
    item = TodoItem.create(due_date: list.list_due_date, title: "task#{count}", completed: false, description: 'Complete  task#{count}', todo_list: list )
    count += 1
  end
end