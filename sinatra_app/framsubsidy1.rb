require 'csv'
require 'bigdecimal'
require 'json'
require "sequel"
require "sinatra"
require 'sinatra/reloader' if development?
require './fetch_euro'
require 'bigdecimal'



# get "/" do
#   # content_type("text/csv")
#   erb :bar
#   @euro = @euro
# end

require 'csv'
require 'bigdecimal'
require 'json'
require "sequel"
require "sinatra"

DB = Sequel.postgres("test")

get "/" do
  # content_type("text/csv")
  
  @payment_amount = DB.fetch('SELECT amount_euro FROM payment').all
  @amount_euro = []

  @payment_amount.each do |row|
    row.each do |key, value|
      @amount_euro << value
    end
  end

    # CSV.generate do |csv|
    #   csv << ["euro"]
    #   i = 0
    #   while i < @euro.length
    #     csv << [@euro[i]]
    #     i += 1
    #   end
    # end
CSV.open("euro.csv", "w", :force_quotes => true) do |csv|
  i = 0
  @total_amount = 0
  @amount_euro.each do |euro|
    while i < 5
      @total_amount = @total_amount + euro
      i += 1
    end
  end
  csv << [@total_amount]
  p @total_amount.class
end

  erb :amount1
end





