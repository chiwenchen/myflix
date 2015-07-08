Fabricator(:video) do #video is the model name
  title {Faker::Lorem.words(4).join(" ")} #title is the parameter
  description {Faker::Lorem.sentence}
end