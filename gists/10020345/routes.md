A summary of the [Rails Guides on Routes](http://edgeguides.rubyonrails.org/routing.html), plus other tips.

The Rails router recognizes URLs and dispatches them to a controller's action.
It can also generate paths and URLs, avoiding the need to hardcode strings in your views.

Examples

```ruby
# Redirects /orders/report to orders#report.
get 'orders/report', to: 'orders#report'

# Redirects /users/pending to /users?approved=false.
get '/users/pending', to: redirect('users?approved=false')

# Dispatches the request "GET /customers/12" to customers controller's show action,
# with { id: '12' } in params.
get 'customers/:id', to: 'customers#show'

```

#### Generating paths and URLs from code

Avoids hardcoding in the view. Reduces brittleness of your view.

```ruby
# Generates the path /customers/12 from code.

get '/customers/:id', to: 'customers#show', as: 'customer'  # Route

@customer = Customer.find(12)  # Controller

= link_to 'Customer Record', customer_path(@customer)  # View
```

#### Resource routing

Declares all common routes for the given resourceful controller.
Instead of declaring separate routes for actions, declares all (index, show, new, edit, create, update, and destroy) in one LoC.

```ruby
# Dispatches a request (e.g. DELETE /photos/12 to destroy method in photos controller)
# with id in params.
resources :photos
```

![](http://i.imgur.com/0g6ZSMR.png)

<sup>Run `rake routes` to see such a table. Notice that some of the paths are the same, which is possible because their HTTP verb is different.</sup>

A resourceful route also exposes helpers to your controllers:  
`photos_path`, `new_photo_path`, `edit_photo_path(id)`, `photo_path(id)`

Each of these helpers has a corresponding `_url` helper (e.g. `photos_url`).
Which returns the same path prefixed with the current host, port, etc.

```ruby
# Multiple resources can be defined at the same time.
resources :photos, :books, :videos
```

#### Singular resources

Singular resources lookup a resource without an ID.
```ruby
# /profile always shows profile of logged in user
get 'profile', to: 'users#show'

# Instead of explicitly stating the `controller#action`, you can map directly to an action
get 'profile', to: :show
```

You can easily create a singular resource with common routes in one LoC.
Note that it will not have an index action (no need since it's a singular resource).
```ruby
resource :geocoder
```
![](http://i.imgur.com/pUz8wVz.png)

**Singular resources map to plural controllers.** E.g. `resource :photo` creates a singular route `/photo` and `resources :photos` creates a plural route `/photos/12`, and both map to the same controller `PhotosController`.

A singular resourceful route generates the helpers

helper | path
--- | ---
`new_geocoder_path` | `/geocoder/new`
`edit_geocoder_path` | `/geocoder/edit`
`geocoder_path` | `/geocoder`

If using `form_for` on a singular resource, you need to specify the url (should be fixed in Rails 4.1+)

```ruby
form_for @geocoder, url: geocoder_path do |f|
```

#### Namespaces

You can organize groups of controllers under a namespace. E.g. administrative controllers under `Admin::` namespace. These controllers would go under `app/controllers/admin` and you would group them in router as

```ruby
namespace :admin do
  resources :posts, :comments
end
```

This will create common routes for `Admin::PostsController` and `Admin::CommentsController`. E.g. for `admin/posts`
![](http://i.imgur.com/MfVIhIE.png)

If you want to route `/posts` instead of `admin/posts` to `Admin::PostsController`, you could use:

```ruby
scope module: 'admin' do
  resources :posts, :comments
end

# or for a single case
resources :posts, module: 'admin'
```

If you want to route `/admin/posts` to `PostsController` (not `Admin::PostsController`), you could use:

```ruby
scope '/admin' do
  resources :posts, :comments
end

# or for a single case
resources :posts, path: '/admin/posts'
```

Note that the paths would still look like `admin/posts` but the controllers and helpers will not contain admin (e.g. `posts#index`, `posts_path`).

#### Nested resources

If your app contains children resources (e.g. post has many comments, comment belongs to post), you can capture this relationship in your routing.

```ruby
resources :posts do
  resources :comments
end
```

This will also create all common routes for ads to an `AdsController`, with paths like `/magazines/:magazine_id/ads`.

This will also create routing helpers such as `magazine_ads_url` and `edit_magazine_ad_path`. These helpers take an instance of Magazine as the first parameter: `magazine_ads_url(@magazine)`, `magazine_ad_path(@magazine, @ad)`

Use nested routes to better express the relationship between ActiveRecord models. But don't nest too deeply, quickly becomes cumbersome. E.g.

```ruby
resources :publishers do
  resources :magazines do
    resources :photos
  end
end

# E.g. /publishers/1/magazines/2/photos/3
```

**Resources should never be nested more than 1 level deep.**

You can avoid deep nesting by nesting the collection actions, but not the member actions. Also called *shallow nesting*. So you build routes with the minimal amount of information needed to uniquely identify the resource. E.g.

```ruby
resources :posts do
  resources :comments, only: [:index, :new, :create]
end
resources :comments, only: [:show, :edit, :update, :destroy]
```

A balance between descriptive routes and deep nesting. There exists shorthand syntax to do the above:

```ruby
resources :posts do
  resources :comments, shallow: true
end
```

The `:shallow` option can also be specified in the parent resource, so all nested resources will be shallow.

```ruby
resources :posts, shallow: true do
  resources :comments
  resources :quotes
  resources :drafts
end

# or using the shallow method

shallow do
  resources :posts do
    resources :comments
    resources :quotes
    resources :drafts
  end
end
```

#### Routing concerns

Concerns allows you to declare common routes that can be reused inside other resources and routes.

```ruby
concern :commentable do
  resources :comments
end
 
concern :image_attachable do
  resources :images, only: :index
end

resources :messages, concerns: :commentable
 
resources :posts, concerns: [:commentable, :image_attachable]
```

This is equivalent to

```ruby
resources :messages do
  resources :comments
end
 
resources :posts do
  resources :comments
  resources :images, only: :index
end
```

#### Custom routes

You're not limited to the 7 routes that RESTful routing creates by default.

**Note:** A member route will require an ID, because it acts on a member. A collection route doesn't because it acts on a collection of objects.

##### Member routes
```ruby
# Single member route (no block)
resources :photos do
  get 'preview', on: :member # Leave out :on option for id to be in params[:photo_id] instead of params[:id]
end

# Multiple member routes
resources :photos do
  member do
    get 'preview' # Options: get, patch, put, post, or delete
    put 'preview'
  end
end
```
This will recognize a GET request to `/photos/1/preview`, and route to the `PhotosController#preview` action, with the resource id value passed in `params[:id]`. It will also create the `preview_photo_url` and `preview_photo_path helpers`.

##### Collection routes
```ruby
# This works, but doesn't have as much magic (e.g. route helpers) as the methods below.
get 'photos/search', to: 'photos#search'

# Single collection route
resources :photos do
  get 'search', on: :collection
end

# Multiple collection route
resources :photos do
  collection do
    get 'search'
    ...
  end
end
```

This will recognize a GET request to `/photos/search`, and route to the `PhotosController#search` action. It will also create the `search_photos_url` and `search_photos_path` route helpers.

##### Routes for additional `new` actions
```ruby
resources :comments do
  get 'preview', on: :new
end
```

This will recognize a GET request to `/comments/new/preview`, and route to the `CommentsController#preview` action. It will also create the `preview_new_comment_url` and `preview_new_comment_path` route helpers.

 **Are you adding lots of extra actions to a resourceful route?** Stop and ask yourself whether you're disguising the presence of another resource!