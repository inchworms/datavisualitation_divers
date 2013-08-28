require 'rubygems'
require 'data_mapper'

DataMapper.setup(:default, "postgres://localhost/farmsubsidy_development")


class Recipient
	include DataMapper::Resource
	property :id, Serial
	property :global_recipient_id, String
	property :name, String
	property :zipcode, String
	property :admin_area_1, String
	property :admin_area_2, String
end

class Payment
	include DataMapper::Resource
	property :id, Serial
	property :recipientId, String
	property :year, Integer
	property :amount, Float
end

class AdminArea1
	property :id, Serial
	property :name, String
	property :country_id, Integer
	# property :geo polygon data
end

class AdminArea2
	property :id, Serial
	property :name, String
	property :admin_area_1_id, Integer
	# property :geo polygon data
end

class Country
	property :id, Serial
	property :name, String
	property :code, Integer
end



DataMapper.finalize



