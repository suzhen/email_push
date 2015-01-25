FactoryGirl.define do
   content = <<-EOF

    <ul id="articles">
      {% for article in articles %}
        <li>
          <h2>{{ article.title }}</h2>
      
          {{article.formatted_html}}

        </li>
      {% endfor %}
    </ul>
  
  EOF
  
  factory :matrix do
    name {Faker::Lorem.word}
    content content
  end

end
