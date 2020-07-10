# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{ username: 'Wakka'},{ username: 'Jim Zimbabawe'},
{ username: 'Ash Ketchup'},{ username: 'The Lich King'},
{ username: 'Not Mike'},{ username: 'Actually Mike'},{ username: "Like Mike"},{ username: 'Paul Blart'},
{ username: "Vanessa Carlton" },{ username: "Gordon Ramsay"},{ username: 'Another Mike'}])

#artist_id, :image_url, :title
artworks = Artwork.create([{artist_id: 7, image_url: 'www.Mike.com', title: 'Team Mike'}])

#:artwork_id, :viewer_id, :users_who_favorited_id, :favorited_artwork_id
# 11 users
# 
artwork_shares = ArtworkShare.create([{artwork_id: 1, viewer_id: 6, users_who_favorited_id: 1, favorited_artwork_id: 1},
{artwork_id: 1, viewer_id: 1},{artwork_id: 1, viewer_id: 2},{artwork_id: 1, viewer_id: 3},
{artwork_id: 1, viewer_id: 4},{artwork_id: 1, viewer_id: 5},{artwork_id: 1, viewer_id: 6},
{artwork_id: 1, viewer_id: 7},{artwork_id: 1, viewer_id: 8},{artwork_id: 1, viewer_id: 9},
{artwork_id: 1, viewer_id: 10},{artwork_id: 1, viewer_id: 11}])

#body: ,  author_id, artwork_id 
comments = Comment.create([{body: 'xd lmao', author_id: 9, artwork_id: 1}, {body: 'the other comment', author_id: 4, artwork_id: 1}])


#user_id, likeable_type, likeable_id
likes = Like.create([{user_id: 9, likeable_type: 'Artwork' , likeable_id: 1},{user_id: 1, likeable_type: 'Comment', likeable_id: 2}])


#user_id, artwork_id
collections = Collection.create([{user_id: 1, artwork_id: 1},{user_id: 2, artwork_id: 1}])