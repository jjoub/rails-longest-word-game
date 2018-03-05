require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
  end

  def score
    @answer_player = params[:answer]
    @letters_sample = params[:letters_sample]

    if @answer_player.upcase.split("").all? { |elem| @letters_sample.split("").include?(elem.capitalize) && @answer_player.count(elem) <= @letters_sample.count(elem.capitalize) }
      found = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@answer_player}").read)

      if found["found"] == true
        @answer = "#{@answer_player} is an english word"
      else
        @answer = "#{@answer_player} is not an english word"
      end
    else
      @answer = "it's not in the grid"
    end
  end
end
