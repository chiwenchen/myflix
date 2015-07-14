Fabricator(:queue_item) do 
  video {Fabricate(:video)}
  user {Fabricate(:user)}
  position {(1..5).to_a.sample}
end