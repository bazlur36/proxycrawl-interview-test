class ScheduleWorker
  include Sidekiq::Worker

  def perform(*args)
    xlsx = Roo::Excelx.new("#{Rails.root}/lib/tasks/amazon_urls.xlsx")
    xlsx.each do |row|
      AmazonDataScrapeWorker.perform_async(row[0].to_s)
    end
  end
end
