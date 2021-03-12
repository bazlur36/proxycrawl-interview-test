class AmazonDataScrapeJob < ApplicationJob

  def perform(url)
    Product.scrape_data(url)
  end
end
