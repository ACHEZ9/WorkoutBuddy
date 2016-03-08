RailsAdmin.config do |config|

  config.authorize_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      username == 'admin' &&
      password == 'admin'
    end
  end

# an initializer to handle conflicting kaminari and will_paginate methods
# config/initializers/will_paginate.rb
if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        def per(value = nil) per_page(value) end
        def total_count() count end
        def first_page?() self == first end
        def last_page?() self == last end
      end
    end
    module CollectionMethods
      alias_method :num_pages, :total_pages
    end
  end
end
  

  RailsAdmin::ApplicationController.class_eval do
    skip_before_filter :require_login
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
