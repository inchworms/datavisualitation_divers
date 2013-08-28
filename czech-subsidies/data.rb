require 'rubygems'
require 'csv'
require 'bigdecimal'
require 'json'


beginning = Time.now

recipient_txt = File.read("cz_recipient.txt")
recipient_parse = CSV.parse(recipient_txt, :headers => true, :col_sep => ";")
@recipient_result = []
recipient_parse.each do |row|
  @recipient_result << {
                  global_recipient_id: row['globalRecipientId'],
                  name: row['name'], 
                  zipcode: row['zipcode'], 
                  # town:
                  # countryRecipient: 
                  # countryPayment:
                  admin_area_1: row['geo1'], 
                  admin_area_2: row['geo2'], 
                  # geo3:
                  # geo4:
                  # geo1NationalLanguage:
                  # geo2NationalLanguage:
                  # geo3NationalLanguage:
                  # geo4NationalLanguage:
                  # lat: 
                  # lng:
                }
end

payment_txt = File.read("cz_payment.txt")
payment_parse = CSV.parse(payment_txt, :headers => true, :col_sep => ";")
@payment_result = []
payment_parse.each do |row|
  @payment_result << {
              # paymentId
              # globalPaymentId
              global_recipient_id: row['globalRecipientId'],
              # globalRecipientIdx
              # globalSchemeId
              amount_euro: row['amountEuro'],
              # amountNationalCurrency
              year: row['year']
              # countryPayment
  }
end

zipcode_txt = File.read("cz_zipcode.csv")
zipcode_parse = CSV.parse(zipcode_txt, :headers => true)
@zipcode_result = []
zipcode_parse.each do |row|
  @zipcode_result << {
              country_code: row['country_code'],
              zipcode: row['zipcode'],
              # place_name
              admin_name_1: row['admin_name_1'],
              # admin_code_1
              admin_name_2: row['admin_name_2']
              # admin_code_2
              # admin_name_3
              # admin_code_3
              # latitude
              # longitude
              # accuracy
  }
end

geo_area_1_txt = File.read("CZE_adm1.json")
geo_area_1_parse = JSON.parse(geo_area_1_txt)
@geo_area_1_result = []
geo_area_1_parse["features"].each do |row|
  @geo_area_1_result << {
                country_name: row["properties"]["NAME_0"],
                # ID_1 : 739
                country_code: row["properties"]["ISO"],
                admin_area_name: row["properties"]["NAME_1"],
                # VARNAME_1 : "Budweis|Budejovický|Ceskobudejovický|South Bohemian"
                # NL_NAME_1 : null
                # HASC_1 : "CZ.CK"
                # CC_1 : null
                # TYPE_1 : "Kraj"
                # ENGTYPE_1 : "Region"
                # VALIDFR_1 : "20010101"
                # VALIDTO_1 : "Present"
                # REMARKS_1 : null
                # Shape_Leng : 6.954809
                # Shape_Area : 1.230583
                geometry: row["geometry"],
                # Polygon
                # coordinates
    }
  end


# p @recipient_result[0]
# p @payment_result[0]
# p @zipcode_result[0]
# p @geo_area_1_result[0]
p @payment_result.length

@total = 0

@payment_result.each do |x|
  if x[:year] == '2007'
    @total = @total + BigDecimal.new(x[:amount_euro])
  end
end

# def from_2007(results)
#   results.select { |x| x[:year] == '2007' }
# end

# def as_big_decimal(results)
#   results.map { |x|
#     BigDecimal.new(x[:amount_euro])
#   }
# end

# def total(results)
#   results.reduce(:+)
# end

# def average(results)
#   num_results = results.size
#   total(results) / num_results
# end

# @total = average(as_big_decimal(from_2007(@payment_result)))

p @total.to_s("F")

puts "Time elapsed #{Time.now - beginning} seconds"

