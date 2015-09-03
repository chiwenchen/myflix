Fabricator(:invitation) do 
  inviter {Fabricate(:user)}
  invitee_email {Faker::Internet.email}
  invitee_name {Faker::Name.name}
  token {SecureRandom.urlsafe_base64}
  message {Faker::Lorem.sentence}
end