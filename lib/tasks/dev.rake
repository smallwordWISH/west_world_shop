namespace :dev do

  task fake_products: :environment do
    Product.destroy_all

    50.times do |i|
      name = FFaker::Product.product_name
      description = FFaker::Lorem.sentence
      price = rand(10..1000)
      image = FFaker::Avatar.image

      product = Product.new(
        name: name,
        description: description,
        price: price,
        image: image
      )

      product.save!
      
    end
    
    puts "have created fake products"
    puts "now you have #{Product.count} product data"
  end

  task fake_all: :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_products'].execute
  end
end