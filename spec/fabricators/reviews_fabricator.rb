Fabricator(:review) do 
  video {Fabricate(:video)}
  user {Fabricate(:user)}
  rating {(1..5).to_a.sample}
  body {Faker::Lorem.sentence(3)}
end