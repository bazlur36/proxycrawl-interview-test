class Product < ApplicationRecord
  validates :title, presence: true

  def self.scrape_data(url)
    scraper = AmazonScraper.new(url)
    product_data_array = scraper.scrap_data
    product_data_array.each do |data|
      product = Product.find_or_initialize_by(asin: data[:asin])
      product.title = data[:title]
      product.img_url = data[:img_url]
      product.price = data[:price]
      product.customer_review = data[:customer_review]
      product.review_count = data[:review_count]
      product.save
    end
  end
end
