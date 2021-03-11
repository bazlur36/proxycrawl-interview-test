require 'proxycrawl'
require 'nokogiri'

class AmazonScraper

  PROXY_CRAWL_NORMAL_TOKEN = '-CMh-gHXWu3MThOzg0hifA'
  PROXY_CRAWL_JS_TOKEN = 'Olwm8cXX5PpOuU0OKu-bsA'

  def initialize(url)
    @api = ProxyCrawl::API.new(token: PROXY_CRAWL_JS_TOKEN)
    @html = @api.get(url)
  end

  def scrap_data
    doc = Nokogiri::HTML(@html.body)
    products_data = []
    products = doc.css('div.s-main-slot div.s-asin')
    products.each do |product|
      product_hash = {}
      product_hash[:title] = product.css('h2 span[dir="auto"]').text
      product_hash[:img_url] = product.css('span[data-component-type=s-product-image] img').attribute('src').value
      product_hash[:price] = product.css('span.a-price[data-a-color=base] span.a-offscreen').text[1..-1]
      review = product.css('div.a-section.a-spacing-none.a-spacing-top-micro')
      product_hash[:customer_review] = review.css('span.a-declarative i span').text
      product_hash[:review_count] = review.css('span.a-size-base').text
      product_hash[:asin] = product.attribute('data-asin').value
      products_data << product_hash
    end
    products_data
  end

end
