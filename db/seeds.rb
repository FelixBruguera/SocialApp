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
include PostsHelper
#nopfp = User.all.select {|user| user.profile_picture.attached? == false}
#nopfp.each {|user| user.update(profile_picture: File.open('app/assets/images/pfp.jpg'))}
# tempo = Tempfile.new(ActiveStorage::Blob.service.path_for(Post.joins(:image_attachment).first.image.key))
# tempo = Tempfile.new(Rails.application.routes.url_helpers.rails_blob_path(tempo, only_path: true))
# filepath = Rails.application.routes.url_helpers.rails_blob_path(tempo, host: 'localhost:3000')
# p filepath
# p File.open(filepath.to_s)
# User.all.each do |pic| 
#     tempo = pic.cover_picture
#     tempo.blob.open do |f|
#     begin
#         img = ActionDispatch::Http::UploadedFile.new(
#             tempfile: f,
#             filename: f.to_s,
#             type: 'image/jpeg'
#         )
#         new_file = resize_before_save(img, 1100, 180)
#         resized = ActionDispatch::Http::UploadedFile.new(
#             tempfile: new_file,
#             filename: new_file.to_s,
#             type: 'image/jpeg'
#         )
#         User.find(pic.id).update(cover_picture: resized)
#     end
#     rescue
#         p 'error'
#     end
# end
# Friend.all.each {|fr| Chat.create(user_id: fr.user_id, friend_id: fr.friend_id) unless Chat.where(user_id: fr.user_id, friend_id: fr.friend_id).or(Chat.where(user_id: fr.friend_id, friend_id: fr.user.id)).exists?}