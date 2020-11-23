require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end
  def score
    @word = params[:word]
    @available_letters = params[:available_letters]
    @word.split('').each do |letter|
      if @available_letters.include?(letter.upcase) && word?(@word)
        @response = "Congratulations! #{@word.upcase} is a valid English word!"
      elsif @available_letters.include?(letter.upcase)
        @response = "Sorry, but #{@word.upcase} is not an English word!"
      else
        @response = "Sorry, but #{@word.upcase} can't be built out of #{@available_letters}"
      end
    end
  end
end

  private

    def word?(word)
      response = open("https://wagon-dictionary.herokuapp.com/#{word}")
      json = JSON.parse(response.read)
      json['found']
    end
#if found = true && use only letters from the words showcased then 'congratulations
# ____ is a valid english word'
#if found = false then 'sorry but ____ does not seem to be a valid english word '
#if found = true but not using the letters then 'sorry but test can't be build out of @letters'
