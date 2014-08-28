module Factories
  class << self
    def errors
      [
        { "UnitycartOrderResponse" =>
          { "OrderResponse" =>
            { "SuccessCode" => "False",
              "ErrorCode" => "Invalid",
              "Errors"=> { "Error" => "Please enter a valid value for ShipState" }}, "lang" => "en-US" }},
        { "UnitycartOrderResponse" =>
          {"OrderResponse" =>
            { "SuccessCode" => "False",
              "ErrorCode"=>"Invalid", "Errors"=>{"Error"=>"Unknown Item Identifier: Item1"}}, "lang"=>"en-US"}},
        { "UnitycartOrderResponse" =>
           { "OrderResponse"=>
              [
                { "SuccessCode"=>"False",
                  "ErrorCode"=>"Invalid",
                  "Errors"=>{"Error"=>"Please enter a valid value for ClientCode" }
                },
                { "SuccessCode"=>"False",
                  "ErrorCode"=>"Failure",
                  "Message"=>"Invalid ClientCode"
                }
              ],
              "lang"=>"en-US" }},
        { "UnitycartOrderResponse"=>
          { "OrderResponse"=>
            { "SuccessCode"=>"False",
              "ErrorCode"=>"Failure",
              "Message"=>"Invalid ClientCode" },
              "lang"=>"en-US" }}
      ]
    end

    def success
      { "UnitycartOrderResponse" =>
        { "OrderResponse" =>
          { "SuccessCode" => "True", "OrderNumber" => "13663856633" }, "lang"=>"en-US" }}
    end
  end
end