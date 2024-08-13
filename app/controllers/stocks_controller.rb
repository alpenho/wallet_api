# Example usage in a controller
class StocksController < ApplicationController
  def show
    @price = LatestStockPrice.price(params[:symbol])
  end

  def index
    @prices = LatestStockPrice.prices(params[:symbols])
  end

  def all_prices
    @all_prices = LatestStockPrice.price_all
  end
end
