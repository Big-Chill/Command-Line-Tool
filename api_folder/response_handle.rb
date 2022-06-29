module ErrorModule
    class ResponseError < StandardError
        def initialize(message)
            super(message)
        end
    end
end