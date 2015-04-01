require 'rails_helper'

RSpec.describe Email, :type => :model do
  
  let(:email){Email.find(7)}

  it "email should Liquid" do

    category_hash = Hash[Category.all.map{|category| [category.slug,category.name]}]

    
    articles_hash = {}

    # articles_hash = {"dan-zai-de-ren-jian_articles"=> Article.where(:category_id=>Category.find_by_slug("dan-zai-de-ren-jian").id),"articles"=>Article.all }

    articles = Article.find(email.articles.map(&:id))

    articles.each do |article|

      category_slug = "#{article.category.slug}_articles"

      if articles_hash[category_slug].nil? 

        articles_hash[category_slug] = []

      end

      articles_hash[category_slug] << article

    end
    puts articles_hash.merge(category_hash)


    # puts "******"
    # puts email.matrix.content
    # puts "******"

    puts Liquid::Template.parse(email.matrix.content).render articles_hash.merge(category_hash)

  end

end
