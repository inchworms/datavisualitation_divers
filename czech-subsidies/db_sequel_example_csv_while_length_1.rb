require 'csv'
require 'bigdecimal'
require 'json'
require "rubygems"
require "sequel"

beginning = Time.now

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
i = 0
payment_txt = CSV.open("cz_payment.txt", "r:UTF8", :headers => true, :col_sep => ";") do |csv|
  csv.each do |row|
    print "." if i%100 == 0
    payment.insert(
      global_recipient_id: row['globalRecipientId'],
      amount_euro: row['amountEuro'],
      year: row['year']
    )
    i += 1
  end
end

# print out the number of records
puts "Payment count: #{payment.count}"

puts "Time elapsed #{Time.now - beginning} seconds"
