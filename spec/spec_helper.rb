# spec_helper.rb
# Existing setup, helpers, etc
# https://sethvargo.com/chef-recipe-code-coverage/
at_exit { ChefSpec::Coverage.report! }
