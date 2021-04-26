# Add the Will Paginate plugin to the gemfile
gem 'will_paginate', '3.0.pre2'

# Place this code in the controller
@items = Item.all.paginate(:page => params[:page] || 1, :per_page => 10)

# Place this code in the view
<%= will_paginate @items %>