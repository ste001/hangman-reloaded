require 'yaml'

def create_dictionary file
  dictionary = []
  File.open(file).each do |word|
    if (word.strip.length >= 5 && word.strip.length <= 12)
      dictionary.push(word.strip)
    end
  end
  dictionary
end

def random_word dictionary
  max = dictionary.length
  random_index = rand(0..max)
  dictionary[random_index]
end

def create_guess_stub solution
  stub = ""
  solution.each_char do |letter|
    stub += "_"
  end
  stub
end

def insert_letters (letter, solution, guess)
  i = 0
  while (i < solution.length)
    if (letter == solution[i])
      guess[i] = letter
    end
    i += 1
  end
end

def game_over? (solution, guess)
  solution == guess
end

def save_game (solution, guess, tries, wrong_letters)
  save = YAML.dump({
    :solution => solution,
    :guess => guess,
    :tries => tries,
    :wrong_letters => wrong_letters
  })
  File.write("save.yaml", save)
  puts "Game saved!"
end

def load_game (file, solution, guess, tries, wrong_letters)
  if (File.exist? file)
    data = YAML.load File.read(file)
    solution = data[:solution]
    guess = data[:guess]
    tries = data[:tries]
    wrong_letters = data[:wrong_letters]
    puts "Game loaded!"
    [solution, guess, tries, wrong_letters]
  else
    puts "WARNING: No saved data"
    false
  end
end

=begin
dictionary = create_dictionary "5desk.txt"
solution = (random_word dictionary).downcase
guess = create_guess_stub solution
tries = 0
wrong_letters = []

puts "Do you want to start a new game or load a saved game?"
puts "Press 1 to load a game, any other key to start a new one."
choice = gets.chomp.to_i
case choice
when 1
  loaded = load_game("save.yaml", solution, guess, tries, wrong_letters)
  if (loaded)
    solution = loaded[0]
    guess = loaded[1]
    tries = loaded[2]
    wrong_letters = loaded[3]
    puts guess
    puts wrong_letters.join(", ")
  else
    puts "New game starting..."
    puts guess
  end
else
  puts "New game starting..."
  puts guess
end

while (not game_over?(solution, guess) || tries >= 6)
  puts "Do you want to insert a letter or save the game?"
  puts "Press 1 to insert a letter, 2 to save the game"
  choice = gets.chomp.to_i
  case choice
  when 1
    puts "Insert a letter: "
    letter = gets.chomp.downcase
    if (solution.include? letter)
      insert_letters(letter, solution, guess)
    else
      wrong_letters.push(letter)
      tries += 1
    end
  when 2
    save_game(solution, guess, tries, wrong_letters)
  else
    "No inputs defined for this key!"
  end
  puts guess
  puts wrong_letters.join(", ")
end

puts tries >= 6 ? "You lost!" : "You win!"
=end