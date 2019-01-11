require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'game'

dictionary = create_dictionary "5desk.txt"
solution = (random_word dictionary).downcase
guess = create_guess_stub solution
tries = 0
wrong_letters = []

get '/hangman' do
  erb :index, :locals => {:guess => guess}
end