require 'csv'
require 'bigdecimal'
require 'json'
require "rubygems"
require "sequel"

beginning = Time.now

payment_txt = File.read("cz_payment.txt")
payment_parse = CSV.parse(payment_txt, :headers => true, :col_sep => ";")
@payment_result = []
payment_parse.each do |row|
  @payment_result << {
              global_recipient_id: row['globalRecipientId'],
              amount_euro: row['amountEuro'],
              year: row['year']
  }
end

# connect to an in-memory database
DB = Sequel.postgres("test")

# drop table payment if exists?
DB.drop_table?(:payment)

# create an items table
DB.create_table :payment do
  primary_key :id
  String :global_recipient_id
  Float :amount_euro
  Float :year
end

# create a dataset from the items table
payment = DB[:payment]

# populate the table
i = 0
while i < @payment_result.length
  payment.insert(:global_recipient_id => @payment_result[i][:global_recipient_id], :amount_euro => @payment_result[i][:amount_euro])
  i += 1
end
# print out the number of records
puts "Payment count: #{payment.count}"

puts "Time elapsed #{Time.now - beginning} seconds"
