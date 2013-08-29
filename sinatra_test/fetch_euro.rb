DB = Sequel.postgres("test")

@amount_euro = DB.fetch('SELECT amount_euro FROM payment').all
@euro = []

@amount_euro.each do |row|
  row.each do |key, value|
    @euro << value
  end
end

@euro = CSV.generate do |csv|
  # csv << ["euro"]
  i = 0
  while i < @euro.length
    csv << [@euro[i]]
    i += 1
  end
end