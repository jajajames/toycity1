require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
require 'date'
puts Date.new(2016, 5, 28)

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "

puts "All prices calculated in dolars\n\n"
items = products_hash['items']
# For each product in the data set:
products_hash["items"].each do |toy|
  # Print the name of the toy
  puts "#{toy['title']}"
  puts"********************"

  # Print the retail price of the toy
  puts "Retail price: #{toy['full-price']}"

  # Calculate and print the total number of purchases
  total_purchases = toy['purchases'].count
  puts "Total purchases: #{total_purchases}"

  # Calculate and print the total amount of sales
  purchases = toy['purchases'].map{ |purchas| purchas['price'] }
  sales_total = purchases.reduce(:+)
  puts "Total Sales: #{sales_total}"

  # Calculate and print the average price the toy sold for
  average_sale = sales_total / total_purchases
  puts "Average sale: #{average_sale}"

  # Calculate and print the average discount (% or $) based off the average sales price
  average_discount = (toy['full-price'].to_f - average_sale).round(2)
  puts "Average discount: #{average_discount}"
  puts
end

	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

brands      = products_hash["items"].map{ |toy| toy['brand']}
uniq_brands = products_hash["items"].map{ |toy| toy['brand']}.uniq
items = products_hash['items']

# For each brand in the data set:
uniq_brands.each do |brand|
  # Print the name of the brand
  puts brand
  puts"********************"


  # Count and print the number of the brand's toys we stock
  brand_toys = items.select { |item| item['brand'] == brand }
# p brand_toys
  brand_quantity = brand_toys.map { |t| t['stock'] }.reduce(:+)
  puts "Number of Products: #{brand_quantity}"

  # Calculate and print the average price of the brand's toys
  brand_purchases = brand_toys.map { |item| item['purchases'] }
  brand_sales = []
  brand_purchases.each{ |toy| toy.each { |sale| brand_sales << sale['price'] } }
  brand_revenue = brand_sales.reduce(:+)
  average_sale = (brand_revenue / brand_sales.count)
  brand_prices = brand_toys.collect { |toy| toy['full-price'].to_f }
  puts "Average Product Price: #{brand_prices.reduce(:+).round(2) / brand_prices.count}"

  # Calculate and print the total revenue of all the brand's toy sales combined
  puts "Total sales: #{brand_revenue.round(2)}"

  puts
end
