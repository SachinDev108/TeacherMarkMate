class SheetsController < ApplicationController
  def index
    @sheet = Sheet.new
  end

  def create
  end
end