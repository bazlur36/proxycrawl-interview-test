namespace :amazon do
  desc "Extract data from Amazon"
  task :scrape_data => :environment do
    scraper = AmazonScraper.new("https://www.amazon.com/s?k=xiaomi+phone&crid=1MKBFKB0YARDU&sprefix=xi%2Caps%2C475&ref=nb_sb_noss_2")
    product_data = scraper.scrap_data
    product_data.each do |product|
      Product.find_or_create_by(title: product[:title], img_url: product[:img_url], price: product[:price].to_f, customer_review: product[:customer_review], review_count: product[:review_count], asin: product[:asin])
    end
  end
end
