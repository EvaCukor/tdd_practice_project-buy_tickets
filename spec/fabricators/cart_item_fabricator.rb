Fabricator(:cart_item) do
  number_of_tickets { [1,2,3,4,5,6].sample }
  ticket_type { ["Balcony", "Floor"].sample }
  ticket_price { rand(50..250) }
end