require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(11)
  end

  def score
    new
    @attempt = params[:WORD]
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt.downcase}"
    response = URI.open(url).read
    json = JSON.parse(response)
    raise
    @english_word = json['found']
    @in_grid = @attempt.downcase.chars.all? { |letter| @attempt.count(letter) <= @letters.count(letter) }
    if @in_grid && @english_word
      @message = "Congratulations! #{@attempt} is a valid English word "
    elsif @english_word == false
      @message = "#{@attempt} is not an english word"
    else
      @message = "#{@attempt} is not in the grid"
    end
  end
end
