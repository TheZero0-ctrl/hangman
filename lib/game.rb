module Hangman
    class Game
        attr_reader :display, :save
        def initialize(display=Display.new, save=Save.new)
            @display = display
            @save = save
        end

        def letters_availabele_to_guess
            ("a".."z").to_a
        end

        def guess_correct?(letter, word)
            return true if word.include?(letter)
            false
        end
        def get_letters
            gets.chomp
        end

        def puts_letter_in_array(letter, word, array)
            word.each_with_index do |elem,index|
                if elem == letter
                    array[index] = letter
                end
            end
        end

        def play
            puts "Welcome to the game"
            puts ("*" * 15) + "H A N G M A N" + ("*" * 15)
            puts "\n"
            puts "Press $ to save game and @ to load game"
            word = display.random_word
            array = display.create_array(word)
            letters_availabele = letters_availabele_to_guess
            chance = 7
            while true
                if chance >= 1
                    display.show_array(array) 
                    puts "\n\nGuess Letters"
                    letter = get_letters
                    if !letter.between?("a", "z")
                        if letter == "$"
                            puts "type file name"
                            save.save_game(word, array, letters_availabele, chance)
                        elsif letter == "@"
                            puts "List of saved game"
                            puts "#" * 50
                            save.show_list_of_save_game
                            puts "type file name to load"
                            word, array, letters_availabele, chance = save.load_game
                        else
                            puts "choose between a to z and the letter you didn't choose already"
                        end
                    elsif letters_availabele.include?(letter) && letter.between?("a", "z")
                        if guess_correct?(letter, word)
                            puts "Your guess is right"
                            puts_letter_in_array(letter, word, array)
                            if array == word
                                display.show_array(array)
                                puts "You guess all letters You win"
                                return
                            end
                        else
                            puts "you guess it wrong"
                            chance -= 1
                        end
                        letters_availabele.delete(letter)
                    elsif letters_availabele.include?(letter)
                        letters_availabele.delete(letter)
                    else
                        puts "You already guess it"
                    end
                else
                    puts "You Lost"
                    puts "Correct word was #{word.join}"
                    return
                end
                puts "\nyou got #{chance} chance"
                puts "*" * 50
            end
        end
    end
end