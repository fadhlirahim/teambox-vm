# teambox cookbook
# This cookbook includes and sets up a teambox server

include_recipe "teambox::dependencies"
include_recipe "teambox::ruby"
include_recipe "teambox::deploy"

