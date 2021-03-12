class ScheduleJob < ApplicationJob

  def perform(*args)
    xlsx = Roo::Excelx.new("#{Rails.root}/lib/tasks/amazon_urls.xlsx")
    xlsx.each do |row|
      AmazonDataScrapeJob.perform_later(row[0].to_s)
    end
  end
end
