require 'csv'
require 'bigdecimal'
require 'json'
require "rubygems"
require "sequel"

DB = Sequel.postgres("test")

@amount_euro = DB.fetch('SELECT amount_euro FROM payment').all

p @amount_euro

@euro = []

@amount_euro.each do |row|
  row.each do |key, value|
    @euro << value.to_s
  end
end

p @euro
p @euro[1]
p @euro.length

CSV.open("euro.csv", "w", :force_quotes => true) do |csv|
  csv << ["euro"]
  i = 0
  while i < @euro.length
    csv << [@euro[i]]
    i += 1
  end
end





