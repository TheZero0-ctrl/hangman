module Hangman
    class Save
        def get_save_file_name
            file_name = "save/" + gets.chomp + ".yml"
            file_name
        end

        def save_game(word, array, letters_availabele, chance)
            config = {
                "word" => word,
                "array" => array,
                "letters_availabele" => letters_availabele,
                "chance" => chance,
            }
            File.open(get_save_file_name, 'w') do |out|   # To file
                YAML.dump(config, out)
             end
        end

        def show_list_of_save_game
            Dir["./save/*"].each {|save_file| puts save_file[7..-5]}
        end

        def load_game
            file_name = "save/" + gets.chomp + ".yml"
            config = YAML.load_file(file_name)
            return config["word"], config["array"], config["letters_availabele"], config["chance"]
        end
    end
end