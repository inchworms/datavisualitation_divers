require 'csv'
require 'bigdecimal'
require 'json'
require "rubygems"
require "sequel"

beginning = Time.now

payment_txt = File.read("countries/DE/payment.txt")
p "payment_txt done"
p "Time elapsed #{Time.now - beginning} seconds" # "Time elapsed 0.785751458 seconds"

payment_parse = CSV.parse(payment_txt, :headers => true, :col_sep => ";")
p "payment_parse done"
p "Time elapsed #{Time.now - beginning} seconds" # "Time elapsed 99.7265785 seconds"

@payment_result_DE = []
payment_parse.each do |row|
  @payment_result_DE << {
    amount_euro: row['amountEuro'],
    year: row['year']
  }
end

@total_DE = 0

i = 0
while i < 20
  @payment_result_DE.each do |x|
    if x[:year] == '2007'
      @total_DE = @total_DE + BigDecimal.new(x[:amount_euro])
    end
  end
  p i
  i += 1
end



# # connect to an in-memory database
# DB = Sequel.postgres("test")

# # drop table payment if exists?
# DB.drop_table?(:payment)

# # create an items table
# DB.create_table :payment do
#   primary_key :id
#   String :global_recipient_id
#   Float :amount_euro
#   Float :year
# end

# # create a dataset from the items table
# payment = DB[:payment]

# # populate the table
# i = 0
# while i < @payment_result.length
#   payment.insert(:global_recipient_id => @payment_result[i][:global_recipient_id], :amount_euro => @payment_result[i][:amount_euro])
#   i += 1
# end
# print out the number of records

puts "DE total Payment count: #{@total_DE}"

puts "Time elapsed #{Time.now - beginning} seconds"
