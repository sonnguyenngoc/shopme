# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
#.....
User.create(:email => "admin@hoangkhang.com.vn", :password => "aA456321@", :password_confirmation => "aA456321@")
#.....

#.....
(1..10).each do |ct|
  cat = Category.create(
    name: "Category demo #{ct}",
    description: "For demo",
    level: "1"
  )
  cat.save
  
  (1..3).each do |ct2|
    child = Category.create(
      name: "Category demo #{ct}.#{ct2}",
      description: "For demo",
      level: "2"
    )
    cat.children << child
    
    (1..2).each do |ct3|
      child2 = Category.create(
        name: "Category demo #{ct}.#{ct2}.#{ct3}",
        description: "For demo",
        level: "3"
      )
      child.children << child2
    end
  end
  
end
#.....