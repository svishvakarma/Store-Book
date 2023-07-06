require 'factory_bot'
FactoryBot.define do
  factory :book do
    name {"Upskilling"}
    price {345}
    author_name {"abc"}
    isbn {345345}
    quantity_available {2}
  end
end
