FactoryGirl.define do
  factory :article do
    title {Faker::Lorem.sentence}
    author {Faker::Name.name}
    editor {Faker::Name.name}
    source {Faker::Company.name}    
    factory :article_content, :class=>'Article' do
      after(:create) do | article | 
        article.article_body.caption = Faker::Lorem.paragraph
        article.article_body.body = Faker::Lorem.paragraph
        article.article_body.formatted_html = "<p>"+Faker::Lorem.paragraph+"</p>"
        article.save
      end
    end
  end
end


# 创建article
# FactoryGirl.create :article_content