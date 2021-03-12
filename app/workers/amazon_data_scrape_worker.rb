class AmazonDataScrapeWorker
  include Sidekiq::Worker

  def perform(url)
    Product.scrape_data(url)
  end
end
