FactoryGirl.define do
  factory :group do
    name {Faker::Company.name}
    factory :group_includes_client, :class=>'Group' do
      after(:create) do | group | 
        group.clients << create_list(:client, 3)
      end
    end
  end
end



# 创建一个组的同时创建三个clients
# FactoryGirl.create :group_includes_client