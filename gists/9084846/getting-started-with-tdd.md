# Getting Started with TDD

## Project Setup

Generate a new Rails project. Skip unit tests and bundle install.

```ruby
rails new -T -B tdd
```

We'll add a couple testing tools.

```ruby
# Gemfile

group :test, :development do 
  gem 'rspec-rails'
end

group :development do
  gem 'shoulda-matchers'
  gem 'capybara'
end
```

Note that we added `rspec-rails` to the development group too. This prevents us from having to type `RAILS_ENV=test` each time we use the generators and tasks bundled with `rspec-rails`.

Run Bundle Install

```ruby
bundle install
```

## Rspec Setup

Create config files and the spec/ directory which houses our tests.

```ruby
rails g rspec:install
```

We need to require Capybara in spec_helper.rb as we will be using it to simulate user interaction for our acceptance tests.

```ruby
# spec/spec_helper.rb

require 'capybara/rails'
```

Now we are all set up. If we run `rspec` we will see 0 examples with 0 failures.

## Our First Spec

We are going to create a very simple blog. We will use a technique called "outside-in" testing where we will start testing the user experience and work our way to unit testing as required. 

Let's create a spec for our first feature - a user managing his or her articles. Our first scenario will involve the user viewing the articles.

```ruby
# spec/features/user_manages_articles_spec.rb

require 'spec_helper'

feature 'User can manage his or her articles' do
  scenario 'Viewing the articles' do
    visit articles_path
    
    expect(page).to have_content('Articles')
  end
end
```

Run `rspec` to watch this test fail.

We need a definition for articles path to fix the issue.

```ruby
# config/routes.rb

resources :articles, only: [:index]
```

Now we need a controller to handle requests for article resources.

```ruby
# app/controllers/articles_controller.rb

def ArticlesController < ApplicationController
end
```

We need an index action to respond to the request.

```ruby
# app/controllers/articles_controller.rb

def index
end
```

We need a template to complete the response.

```ruby
# app/views/articles/index.html.erb
```

The template should include the word "Articles"

```ruby
# app/views/articles/index.html.erb

<h1>Articles</h1>
```

And success. Our first scenario for our first feature passes. On to our second scenario.

```ruby
# spec/features/user_manages_articles_spec.rb

scenario 'Adding an article' do
  visit articles_path
    
  click_link 'Add article'
    
  fill_in 'Title', with: 'My first article'
  click_button 'Save'
    
  expect(page).to have_content('My first article')
end
```

We need to add a link.

```ruby
# views/articles/index.html.erb

<%= link_to 'Add article', new_article_path %>
```

We need to update our routes.

```ruby
# config/routes.rb

resources :articles, only: [:index, :new]
```

We need to update our controller with the new action.

```ruby
# app/controllers/articles_controller.rb

def new
end
```

And add the template...

```ruby
# app/views/articles/new.html.erb
```

Create a form with a field to fill in.

```ruby
# app/views/articles/new.html.erb

<%= form_for @article do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
<% end %>
```

Now we need a model

```ruby
rails g model article title:string
rake db:migrate
rake db:test:prepare
```

And instantiate it in the new action.

```ruby
# app/controllers/articles_controller

def new
  @article = Article.new
end
```

We need a button to save the record.

```ruby
# app/views/articles/new.html.erb

<%= form_for @article do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  
  <%= f.submit 'Save' %>
<% end %>
```

Update our routes again:

```ruby
# config/routes.rb

resources :articles, only: [:index, :new, :create]
```

Update our controller:

```ruby
# app/controllers/articles_controller.rb

def create
end
```

Missing template. But we need to create a record and redirect.

```ruby
# app/controllers/articles_controller.rb

def create
  @article = Article.new(params.require(:article))
end
```

Whitelist attributes.

```ruby
# app/controllers/articles_controller.rb

def create
  @article = Article.create(params.require(:article).permit(:title))
end
```

Redirect

```ruby
# app/controllers/articles_controller.rb

def create
  @article = Article.create(params.require(:article).permit(:title))
  redirect_to articles_path
end
```

We expect articles to be shown on the articles page. Let's add them to the template.

```ruby
# app/views/articles/index.html.erb

<h1>Articles</h1>

<%= @articles.each do |article| %>
  <%= article.title %>
<% end %>

<%= link_to 'Add article', new_article_path %>
```

Update the index method.

```ruby
# app/controllers/articles_controller.rb

def index
  @articles = Article.all
end
```