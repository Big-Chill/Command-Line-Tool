require 'httparty'

module GetWord
    def GetWord.get_word
        response = HTTParty.get("https://fourtytwowords.herokuapp.com/words/randomWord?api_key=be45adfee7c617ff1b22a4ffccdf2687a8b7f484d1fc0603388c9f5d51879871e6fa92b0cb6fa6915f86e5c59d2c815b45496db11041a065ff6339318c925201")
        if (response.code != 200)
            return response.code
        else
            word = response.body
            word = JSON.parse(word)
            return word["word"]
        end
    end
end