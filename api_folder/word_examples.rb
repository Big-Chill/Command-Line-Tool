$LOAD_PATH << "."
require 'httparty'
require "C:/Final Command Line Project/api_folder/response_handle.rb"

module WordExample
    def WordExample.getExample(word)
        begin
            resp=HTTParty.get("http://fourtytwowords.herokuapp.com/word/#{word}/examples?api_key=be45adfee7c617ff1b22a4ffccdf2687a8b7f484d1fc0603388c9f5d51879871e6fa92b0cb6fa6915f86e5c59d2c815b45496db11041a065ff6339318c925201")
            if(resp.code != 200)
                raise ErrorModule::ResponseError.new(resp.code)
            end
        rescue => e
            return "#{e}"
        else
            resp = resp.body
            resp = JSON.parse(resp)
            return resp["examples"]
        end
    end
end