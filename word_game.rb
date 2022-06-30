$LOAD_PATH << "."
require "word_module"

module WordGame
    $synonyms = []
    $antonyms = []
    $definitions = []
    $current_score = 0
    $is_correct = false
    $user_word = ""
    $cobj = WordModule::WordClass.new
    $currTurn = 0
    $curr_synonym = []

    class Game

        def new_game
            $is_correct = false
            $currTurn = 0
            $curr_synonym = []
            $curr_antonym = []
            $curr_definition = []
            puts "Current Score :- #{$current_score}"
            puts ""
            puts "FIRST HINT :- "
            hint = $cobj.display_random_hint
            type_of_hint = hint.keys[0]
            value_of_hint = hint.values[0]
        
            while(value_of_hint == false)
                hint = $cobj.display_random_hint
                type_of_hint = hint.keys[0]
                value_of_hint = hint.values[0]
            end
            
            if(type_of_hint == "SYNONYM")
                $curr_synonym.push(value_of_hint)
            end
            puts "#{type_of_hint} :- #{value_of_hint}"
        
            puts ""
            puts "ENTER YOUR GUESSED WORD :- "
            $user_word = gets.chomp
            $currTurn = 1
            if($user_word == $cobj.get_word || $cobj.is_a_synonym($user_word))
                puts "CORRECT GUESS"
                $current_score = $current_score + 10
                puts ""
                puts "YOUR SCORE :- #{$current_score}"
                $cobj.generate_new_word
                new_game
            else
                if($user_word == "-1")
                    puts "YOU QUIT THE GAME"
                    puts "FINAL SCORE :- #{$current_score}"
                    exit
                end
                $current_score = $current_score - 2
                puts "INCORRECT GUESS"
                puts ""
                puts "YOUR SCORE :- #{$current_score}"
                puts ""
            end
        
        end
        
        def old_game
            puts "PRESS 1 TO TRY AGAIN"
            puts "PRESS 2 TO GET A NEW HINT"
            puts "PRESS 3 TO SKIP"
            choice = gets.chomp
        
            case choice
        
            when "1"
                puts "ENTER YOUR GUESSED WORD :- "
                puts ""
                $user_word = gets.chomp

                if($user_word == "-1")
                    puts "YOU QUIT THE GAME"
                    puts "FINAL SCORE :- #{$current_score}"
                exit
                end

                if($user_word == $cobj.get_word || $cobj.is_a_synonym($user_word))
                    $current_score = $current_score + 10
                    puts "CORRECT ANSWER"
                    puts ""
                    puts "NEW GAME STARTING"
                    puts ""
                    $cobj.generate_new_word
                    new_game
                else
                    $current_score = $current_score - 2
                    puts ""
                    puts "INCORRECT ANSWER"
                    puts ""
                    puts "YOUR SCORE :- #{$current_score}"
                end
        
            when "2"
                $current_score = $current_score - 3
                puts "NEW HINT :- "
                puts ""
                hint = $cobj.display_random_hint
                type_of_hint = hint.keys[0]
                value_of_hint = hint.values[0]
        
                if(value_of_hint == "END")
                    puts "JUMBLED WORD :- #{$cobj.get_jumbled_word}"
                    puts ""
                else
                    while(value_of_hint == false)
                        hint = $cobj.display_random_hint
                        type_of_hint = hint.keys[0]
                        value_of_hint = hint.values[0]
                    end
                    
                    if(type_of_hint == "SYNONYM")
                        $curr_synonym.push(value_of_hint)
                    end
                    puts "#{type_of_hint} :- #{value_of_hint}"
            
                    puts ""
                    puts "YOUR SCORE :- #{$current_score}"
                    puts ""
                end
        
            when "3"
                $current_score = $current_score - 4
                $cobj.get_all_details
                puts ""
                puts "YOUR SCORE :- #{$current_score}"
                puts ""
                $cobj.generate_new_word
                puts "NEW GAME STARTING"
                puts ""
                new_game
            when "-1"
                puts "YOU QUIT THE GAME"
                puts "FINAL SCORE :- #{$current_score}"
                exit
            else
                puts "INVALID INPUT"
            end
        end

        def start_game
            until $user_word =="-1"

                if($currTurn == 0)
                    new_game
                else
                    puts ""
                    old_game
                end
            end
        end
    end
end
