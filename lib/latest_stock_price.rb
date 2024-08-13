require 'net/http'
require 'json'

module LatestStockPrice
  BASE_URL = 'https://latest-stock-price.p.rapidapi.com'

  def self.price(symbol)
    url = "#{BASE_URL}/price?symbol=#{symbol}"
    fetch_data(url)
  end

  def self.prices(symbols)
    url = "#{BASE_URL}/prices?symbols=#{symbols.join(',')}"
    fetch_data(url)
  end

  def self.price_all
    url = "#{BASE_URL}/price_all"
    fetch_data(url)
  end

  private

  def self.fetch_data(url)
    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    request['X-RapidAPI-Key'] = ENV['RAPIDAPI_KEY'] # Replace with your actual RapidAPI key
    request['X-RapidAPI-Host'] = 'latest-stock-price.p.rapidapi.com'

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
    nil
  end
end
