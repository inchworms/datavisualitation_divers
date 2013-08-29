require 'csv'
require 'bigdecimal'
require 'json'
require "sequel"
require "sinatra"
# require 'sinatra/reloader' if development?
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
  @total_amount = 0
  @amount_euro.each do |euro|
    @total_amount = @total_amount + BigDecimal.new(euro.to_i)
  end
  erb :amount
end





