$LOAD_PATH << "."
require "C:/Final Command Line Project/api_folder/generate_word.rb"
require "C:/Final Command Line Project/api_folder/related_words.rb"
require "C:/Final Command Line Project/api_folder/response_handle.rb"
require "C:/Final Command Line Project/api_folder/word_definition.rb"
require "C:/Final Command Line Project/api_folder/word_examples.rb"

module WordModule
    class WordClass
        def initialize()
            @word = GetWord.get_word()
            rel_words_arr = RelWords.getRelatedWords(@word)
            if(rel_words_arr.class == String)
                return
            end
    
            if(rel_words_arr.length==1)
                $synonyms = rel_words_arr[0]["words"]
            else
                $antonyms = rel_words_arr[0]["words"]
                $synonyms = rel_words_arr[1]["words"]
            end
    
            def_arr = WordDef.getDefinitions(@word)
            def_arr.each do |obj|
                obj.each do |key,value|
                    $definitions.push(value)
                end
            end
        end
    
        def get_word()
            return @word
        end
    
        def generate_new_word()
            initialize()
        end
    
        def print_definition()
            puts "DEFINITION OF #{@word} :- "
            word_def = WordDef.getDefinitions(@word)
    
            if(word_def.class == String)
                puts "SOME ERROR OCCURED"
            else
                k = 1
                word_def.each do |obj|
                    obj.each do |key,value|
                        puts "#{k}. #{value}"
                        k = k+1
                    end
                end
            end
        end
    
        def display_synonyms()
            rel_arr = RelWords.getRelatedWords(@word)
            if(rel_arr.class == String)
                puts "SOME ERROR OCCURED"
                exit
            end
    
            if(rel_arr.length==1)
                puts "SYNONYMS OF #{@word} :- "
                reqd_syn=rel_arr[0]["words"]
                reqd_syn.each do |obj|
                    puts obj
                end
            else if(rel_arr.length==2)
                puts "SYNONYMS OF #{@word} :- "
                reqd_syn=rel_arr[1]["words"]
                reqd_syn.each do |obj|
                    puts obj
                    end
                end
            end
        end
    
        def display_antonyms()
            rel_arr=RelWords.getRelatedWords(@word)
            if(rel_arr.class == String)
                puts "SOME ERROR OCCURED"
                exit
            end
            if(rel_arr.length==2)
                puts "ANTONYMS OF #{@word} :- "
                reqd_ant=rel_arr[0]["words"]
                reqd_ant.each do |obj|
                    puts obj
                end
            else
                puts "NO ANTONYMS FOUND"
            end
        end
    
        def display_examples()
            examples=WordExample.getExample(@word)
            if(examples.class == String)
                puts "SOME ERROR OCCURED"
                exit
            end
            puts "EXAMPLES OF #{@word} :- "
            k=1
            examples.each do |obj|
                obj.each do |key,value|
                    puts "#{k}. #{value}"
                    k=k+1
                end
            end
        end
    
        def get_all_details()
            puts "CURRENT WORD :- #{@word}"
            puts ""
            print_definition()
            puts ""
            display_synonyms()
            puts ""
            display_antonyms()
            puts ""
            display_examples()
        end
    
        def display_word_of_the_day()
            puts "WORD OF THE DAY :- #{@word}"
            print_definition()
            puts ""
            display_synonyms()
            puts ""
            display_antonyms()
            puts ""
            display_examples()
        end
    
        def display_random_hint()
            if($definitions.length==0 && $synonyms.length==0 && $antonyms.length==0)
                ans = Hash.new
                ans["END"] = "END"
                return ans
            end
    
    
            ch = rand(1..3)
            if(ch ==  1)
                sym = get_a_synonym()
                $synonyms.delete(sym)
                ans = Hash.new
                ans["SYNONYM"] = sym
                return ans
            end
            if(ch==2)
                ant = get_a_antonym()
                $antonyms.delete(ant)
                ans = Hash.new
                ans["ANTONYM"] = ant
                return ans
            end
    
            if(ch==3)
                defi = get_a_definition()
                $definitions.delete(defi)
                ans = Hash.new
                ans["DEFINITION"] = defi
                return ans
            end
        end
    
        def is_a_synonym(word)
            syn_arr = get_synonyms()
            if(syn_arr.class == String)
                return false
            end
    
            $curr_synonym.each do |obj|
                if(obj==word)
                    puts "YOU CANT USE THIS SYNONYM AS IT WAS SHOWN AS A HINT"
                    return false
                end
            end
    
            syn_arr.each do |obj|
                if(obj==word)
                    return true
                end
            end
            return false
        end
    
        def get_jumbled_word()
            w = @word
            w = w.split("")
            w.shuffle!
            w = w.join("")
            return w
        end

        private
        def get_a_definition()
            if($definitions.length ==0)
                return false
            end
            rnum = rand(0...$definitions.length)
            return $definitions[rnum]
        end
    
        def get_a_synonym()
            if($synonyms.length ==0)
                return false
            end
            rnum = rand(0...$synonyms.length)
            return $synonyms[rnum]
        end

        def get_a_antonym()
            if($antonyms.length==0)
                return false
            end
            rnum = rand(0...$antonyms.length)
            return $antonyms[rnum]
        end
    
        def get_synonyms()
            rel_arr = RelWords.getRelatedWords(@word)
            if(rel_arr.class == String)
                puts "SOME ERROR OCCURED"
                exit
            end
            if(rel_arr.length==1)
                return rel_arr[0]["words"]
            else if(rel_arr.length==2)
                return rel_arr[1]["words"]
                end
            end
        end
    end
end