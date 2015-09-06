Fabricator(:event) do
  name { Faker::Lorem.words(5).join(" ") }
  venue { Faker::Lorem.words(3).join(" ") }
  description { Faker::Lorem.paragraph(2) }
  date { Faker::Date.forward(23) }
  time { Faker::Time.forward(23, :evening) }
end