###
# Compass
###
require 'susy'
# Change Compass configuration

  compass_config do |config|
    config.sass_options = {:debug_info => true}
  end


###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Markdown settings 
set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true, :with_toc_data => true
set :markdown_engine, :redcarpet


set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :fonts_dir,  "fonts"

# Reload the browser automatically whenever files change
activate :livereload



# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

end

after_configuration do
  bowerrc = JSON.parse File.read(File.join "#{root}", '.bowerrc')
  bower_dir = bowerrc['directory']
  sprockets.append_path File.join("#{root}", bower_dir)

  Dir.glob File.join "#{root}", bower_dir, '**/*', '{bower,component,.bower}.json' do |f|
    bower = JSON.parse File.read(f), create_additions: false
    dirname = File.dirname f
    case bower['main']
    when String
      sprockets.append_path File.dirname(File.join(dirname, bower['main']))
    when Array
      bower['main'].each do |name|
        sprockets.append_path File.dirname(File.join(dirname, name))
      end
    end
  end
end
