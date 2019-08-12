require 'open-uri'
require 'nokogiri'

class GamesController < ApplicationController
  def new
    @array = calculate
  end

  def score
    array = params[:array]
    @created_word = params[:word]
    @user = {}
    url = "https://wagon-dictionary.herokuapp.com/#{@created_word}"
    response = open(url).read
    @data = JSON.parse(response)

    @exist = true
    @data["word"].split.each do |letter|
      @exist = false unless array.include?(letter)
    end

    if @exist == true && @data["found"] == true
      @result = "Conguratulations!#{@created_word} is an English word!"
    elsif @exist == false
      @result = "Sorry #{@created_word} can't be build of #{array}"
    else
      @result = "Sorry but #{@created_word} does not seem like an English word..."
    end
  end

  private

  def calculate
    (0..10).map { ('A'..'Z').to_a[rand(26)] }
  end
end
