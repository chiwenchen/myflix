Fabricator(:user) do 
  name {Faker::Name.name}
  password {"password"}
  email {Faker::Internet.email}
end