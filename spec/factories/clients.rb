FactoryGirl.define do
  factory :client do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    tel {Faker::Company.duns_number}
    fax {Faker::Company.duns_number}
    address {Faker::Address.street_address}
    mobile {Faker::PhoneNumber.phone_number}
    title {Faker::Name.title}
  end
end
