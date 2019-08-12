require 'open-uri'
require 'nokogiri'

class GamesController < ApplicationController
  def new
    @array = calculate
    session[:count] = 0
  end

  def score
    array = params[:array].downcase
    @created_word = params[:word]
    session[:count] = @created_word.split('').count
    @calcul = session[:count] * session[:count]
    @user = {}
    url = "https://wagon-dictionary.herokuapp.com/#{@created_word}"
    response = open(url).read
    @data = JSON.parse(response)
    @exist = true
    @data["word"].split('').each do |letter|
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

  def create
    session[:user_id] = "m/ueqGM7N8x8wJSEEAvWI8T/60dlGKH9Ad0NkpB7mgRVb2PlzQUh5kIU76yG7kJW1P/uBGKB7IOC/w/sMBIwxw=="
  end
end
