module Hangman
    class Display
        attr_reader :words
        def initialize(filename='wordlist.txt')
            @words = File.readlines(filename)
        end

        def selected_words
            words.select {|word| word.length.between?(6, 12)}
        end

        def random_word
            selected_words.sample.gsub!("\n", "").downcase.split("")
        end

        def create_array(word)
            Array.new(word.length, '_')
        end

        def show_array(array)
            array.each {|letter| print letter + " "}
        end
    end
end