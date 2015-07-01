Fabricator(:review) do 
  video_id {Fabricate(:video).id}
  user_id {Fabricate(:user).id}
  rating {(1..5).to_a.sample}
  body {Faker::Lorem.sentence(3)}
end