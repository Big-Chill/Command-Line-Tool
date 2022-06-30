require 'httparty'

module RelWords
    def RelWords.get_related_words(actWord)
        resp = HTTParty.get("http://fourtytwowords.herokuapp.com/word/#{actWord}/relatedWords?api_key=be45adfee7c617ff1b22a4ffccdf2687a8b7f484d1fc0603388c9f5d51879871e6fa92b0cb6fa6915f86e5c59d2c815b45496db11041a065ff6339318c925201")
        if(resp.code != 200)
            return resp.code
        else
            return resp
        end
    end
end