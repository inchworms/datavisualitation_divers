require 'rubygems'
require 'sequel'

# connect to an in-memory database
DB = Sequel.connect('postgres://user:password@localhost/farmsubsidy_development')
DB = Sequel.postgres('farmsubsidy_development', :user => 'user', :password => 'password', :host => 'localhost')


# create a recipients table
DB.create_table :recipients do
  primary_key :id
  String :global_recipient_id
  String :name
  String :zipcode
  String :admin_area_1
  String :admin_area_2
end

# create a dataset from the recipients table
# items = DB[:recipients]
