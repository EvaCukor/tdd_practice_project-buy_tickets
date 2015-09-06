Fabricator(:category) do
  events(count: 2)
  name { Faker::Lorem.word }
end