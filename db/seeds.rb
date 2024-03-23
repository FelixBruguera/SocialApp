# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# User.create(first_name: 'Betzabeth', last_name: 'Bruguera', email: 'betza@gmail.com', password: 123456, profile_picture: 'assets/images/pfp.jpg')
# User.create(first_name: 'Test', last_name: 'Two', email: 't@2.com', password: 123456)
# Friend.create(user_id: User.first.id, friend_id: User.last.id)
# Post.create(body:'testing posts', user_id:6)
# Post.create(body:'another testing posts', user_id:6)
nopfp = User.all.select {|user| user.profile_picture.attached? == false}
nopfp.each {|user| user.update(profile_picture: File.open('app/assets/images/pfp.jpg'))}
