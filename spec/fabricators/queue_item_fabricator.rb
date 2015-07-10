Fabricator(:queue_item) do 
  video {Fabricate(:video)}
  user {Fabricate(:user)}
  rating {(1..5).to_a.sample}
  position {(1..5).to_a.sample}
end