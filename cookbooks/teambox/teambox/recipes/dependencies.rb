#For teambox server
require_recipe "ubuntu"
require_recipe "logrotate"
require_recipe "java"
require_recipe "git"
include_recipe "passenger_enterprise::nginx"
require_recipe "mysql::server"
require_recipe "sphinx"
require_recipe "memcached"
include_recipe "imagemagick::rmagick"
ree_gem "rake"
ree_gem "bundler"

#For postgresql gem in Gemfile
require_recipe "postgresql::client"
package "libpq-dev"

require_recipe "sqlite"
package "libsqlite3-dev"

#For nokogiri in Gemfile
package "libxslt1-dev"

