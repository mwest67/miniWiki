ActionController::Routing::Routes.draw do |map|
  map.root :controller => :pages
  map.connect '/pages/browse',  :controller => :pages, :action => :browse
  map.connect '/pages/search',  :controller => :pages, :action => :search
  map.connect '/pages/find/:title',  :controller => :pages, :action => :find
  map.connect '/pages/tag_cloud',  :controller => :pages, :action => :tag_cloud
  map.connect '/pages/search_tagged',  :controller => :pages, :action => :search_tagged
  map.connect '/pages/delete_attachment', :controller => :pages, :action => :delete_attachment

  map.resources  :pages
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
