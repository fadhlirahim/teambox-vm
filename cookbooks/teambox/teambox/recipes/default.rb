# teambox cookbook
# This cookbook includes and sets up a teambox server
#
include_recipe "git"
include_recipe "imagemagick"
require_recipe "passenger_enterprise::nginx"
require_recipe "mysql"
memcached_instance "teambox"
ree_gem "bundler"
